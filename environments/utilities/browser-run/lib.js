#!/usr/bin/env node
var path = require('path')
var nopt = require('nopt')
var noptUsage = require('nopt-usage')
var shelljs = require('shelljs')
var fs = require('fs')
var express = require('express')
var app = express()
require('express-ws')(app)

var knownOpts = {
  'expression': String,
  'help': Boolean,
  'verbose': Boolean
}
var shortHands = {
  'e': ['--expression'],
  'h': ['--help'],
  'v': ['--verbose']
}
var description = {
  'expression': 'expression to evaluate instead of a file',
  'help': 'display this help',
  'verbose': 'show results from intermediary stages'
}
var parsed = nopt(knownOpts, shortHands)
var missingArgument = (parsed.argv.remain.length < 1 && !parsed.expression)
var firstArgumentIndex = parsed.expression ? 0 : 1

if (parsed.help || missingArgument) {
  var usage = 'usage: run [options] file [A [A ...]]\n\n' +
    'Unified interface for running javascript functions in a browser.\n\n' +
    'positional arguments:\n' +
    '  file\t\tJavaScript file to execute in the browser\n' +
    '  A\t\tpositional argument(s) to pass to the function\n\n' +
    'optional arguments: \n' +
    noptUsage(knownOpts, shortHands, description)
  console.log(usage)
  process.exit(1)
}

app.use('/page', express.static(path.join(__dirname, './public')))
app.use('/build', express.static(path.dirname(parsed.argv.remain[0]).toString()))
app.use('/input', express.static(path.join(__dirname, './input')))

function bashToJavaScript (a) {
  if (Number.parseInt(a, 10) || Number.parseFloat(a)) {
    return a.toString()
  }

  if (a.indexOf('@') >= 0) {
    var tuple = a.split('@')
    var type = tuple[0].split('-')
    var inputPath = tuple[1]

    // Expected type
    if (type[0] !== 'array') {
      console.log("Invalid type '" + tuple[0] + "', expected an 'array' prefix from argument '" + a + "'")
      process.exit(1)
    }

    if (type[1] !== 'int32' &&
      type[1] !== 'float64') {
      console.log("Invalid array type '" + tuple[1] + "', expected an 'int32' or 'float64'")
      process.exit(1)
    }

    var size = type.slice(2).map(Number)

    // Input file
    var ext = path.extname(inputPath)

    var data = []
    var fileData
    if (ext === '.csv') {
      fileData = fs.readFileSync(inputPath).toString()
      fileData.split('\n').forEach(function (line) {
        if (line === '') return
        line.split(',').forEach(function (s) {
          var n = Number.parseInt(s, 10) || Number.parseFloat(s)
          if (!n) {
            console.log("Invalid number '" + s + "' in file " + inputPath)
            process.exit(1)
          }
          data.push(n)
        })
      })
    } else if (ext === '.pgm') {
      fileData = fs.readFileSync(inputPath).toString()
      fileData.split('\n').slice(3).forEach(function (line) {
        if (line === '') return
        line.split(' ').forEach(function (s) {
          if (s === '') return
          var n = Number.parseInt(s, 10) || Number.parseFloat(s)

          if (n === null) {
            console.log("Invalid null value for '" + s + "'")
          }
          if (!n) {
            console.log("Invalid number '" + s + "' in file " + inputPath)
            process.exit(1)
          }
          data.push(n)
        })
      })
    } else {
      console.log("Unsupported extension '" + ext + "'")
      process.exit(1)
    }

    var jsArrayType = ((type[1] === 'int32') ? 'Int32Array' : 'Float64Array')

    var array = '{\n' +
      "        type: 'array',\n" +
      "        'array-type': " + JSON.stringify(type[1]) + ',\n' +
      '        size: ' + JSON.stringify(size) + ',\n' +
      "        layout: 'row-major'" + ',\n' +
      '        data: ' + 'new ' + jsArrayType + '(' + JSON.stringify(data) + ')\n' +
      '    }'

    return array
  }

  return "'" + a.toString() + "'"
}
function indent (x) {
  return '    ' + x
}

app.ws('/socket', function (ws, req) {
  // Serialize arguments to the input args file
  var args = ['var args = []']
  parsed.argv.remain.slice(firstArgumentIndex).forEach(function (x, i) {
    args.push('args[' + i + '] = (' + bashToJavaScript(x) + ')')
  })
  args.push('return args')
  fs.writeFileSync(path.join(__dirname, 'input', 'args.js'),
    'define(function () {\n' +
    args.map(indent).join('\n') + '\n' +
    '})'
  )

  // Determine files to load
  var modules = ['/input/args.js']
  if (!parsed.expression) {
    modules.push(path.join('/build', path.basename(parsed.argv.remain[0])))
  }

  // Generate code to run. First load dependencies, then execute the code
  var code = 'require([' + modules.map(JSON.stringify).join(',') + '], function (args) {\n' +
    parsed.expression + ';\n' +
    "try {\n" + 
    "  if (typeof runner === 'function' ) {\n" +
    '    runner.apply(null, args)\n' +
    "    if (runner.toString().indexOf('server.done') === -1) {\n" +
    '        server.done()\n' +
    '    }\n' +
    '  }\n' +
    "  else if (typeof run === 'function' ) {\n" +
    '    run.apply(null, args)\n' +
    "    if (run.toString().indexOf('server.done') === -1) {\n" +
    '        server.done()\n' +
    '    }\n' +
    '  }\n' +
    '} catch (e) {\n' +
    '  server.log(e)\n' +
    '  server.error(e.stack)\n' +
    '}})'

  var cmd = JSON.stringify({ 'type': 'eval', 'code': code })
  if (parsed.verbose) {
    console.log('Sending: ' + cmd)
  }
  ws.send(cmd)

  ws.on('message', function (msg) {
    if (parsed.verbose) {
      console.log('Received: ' + msg)
    }

    try {
      var o = JSON.parse(msg)
      if (o.type === 'done') {
        ws.send(JSON.stringify({ 'type': 'close' }), function (error) {
          if (error) {
            process.stderr.write(error + '\n')
            process.exit(1)
          } else {
            process.exit(0)
          }
        })
      } else if (o.type === 'status') {
        if (parsed.verbose && o.status === 'connected') {
          console.log('Connection confirmed')
        }
      } else if (o.type === 'output') {
        console.log(o.output)
      } else if (o.type === 'load') {
        var data = JSON.stringify({
          'type': 'loadresult',
          'data': fs.readFileSync(o.path).toString()
        })
        ws.send(data)
      } else if (o.type === 'save') {
        fs.writeFileSync(o.path, o.data)
      } else if (o.type === 'error') {
        process.stderr.write(o.message + '\n')
        process.exit(1)
      } else {
        if (parsed.verbose) {
          console.log('Unknown message: ' + msg)
        }
      }
    } catch (e) {
      if (parsed.verbose) {
        console.log('Invalid JSON from message: ' + msg)
      }
    }
  })

  process.stdin.on('readable', function () {
    var chunk = process.stdin.read()
    if (chunk !== null) {
      ws.send(chunk.toString())
    }
  })
})

exports.start = function (startCmd) {
  app.listen(8080, function (err) {
    if (err) {
        console.log(err)
        process.exit(1)
    }
    var cmd = startCmd + ' http://localhost:8080/page/run.html'
    if (parsed.verbose) {
        console.log('executing ' + cmd)
    }
    var status = shelljs.exec(cmd, {silent: !parsed.verbose}, function (code, stdout, stderr) {
        if (code !== 0) {
          console.log("Execution error for '" + cmd + "':")
          console.log(status.output)
          process.exit(1)
        }
    })
  })
}
