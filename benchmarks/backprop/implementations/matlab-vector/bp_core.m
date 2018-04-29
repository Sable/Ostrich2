function [hidden_weights] = bp_core(input_units, hidden_units, input_weights, in, hid, out, output_delta, target, output_units, hidden_delta, hidden_prev_weights, input_prev_weights, hidden_weights)
% bpnn_train_kernel
  [input_units, hidden_units] = bpnn_layerforward(input_units, hidden_units, input_weights, in, hid);
  [hidden_units, output_units] = bpnn_layerforward(hidden_units, output_units, hidden_weights, hid, out);
  [out_err, output_delta] = bpnn_output_error(output_delta, target, output_units, out);
  [hid_err, hidden_delta] = bpnn_hidden_error(hidden_delta, hid, output_delta, out, hidden_weights, hidden_units);
  [hidden_units, hidden_weights, hidden_prev_weights] = bpnn_adjust_weights(output_delta, out, hidden_units, hid, hidden_weights, hidden_prev_weights);
  [input_units, input_weights, input_prev_weights] = bpnn_adjust_weights(hidden_delta, hid, input_units, in, input_weights, input_prev_weights);
end
function [errsum, delta_h] = bpnn_hidden_error(delta_h, nh, delta_o, no, who, hidden)
  errsum = 0.0;
  mc_t82 = 2;
  for j = (mc_t82 : nh);
    [h] = hidden(j);
    s = 0.0;
%sum
    mc_t80 = 2;
    for k = (mc_t80 : no);
      mc_t69 = s;
      [mc_t71] = delta_o(k);
      [mc_t72] = who(j, k);
      [mc_t70] = times(mc_t71, mc_t72);
      [s] = plus(mc_t69, mc_t70);
    end
    mc_t75 = h;
    mc_t81 = 1.0;
    [mc_t76] = minus(mc_t81, h);
    [mc_t73] = times(mc_t75, mc_t76);
    mc_t74 = s;
    [mc_t68] = times(mc_t73, mc_t74);
    delta_h(j) = mc_t68;
    mc_t77 = errsum;
    [mc_t79] = delta_h(j);
    [mc_t78] = abs(mc_t79);
    [errsum] = plus(mc_t77, mc_t78);
  end
end
function [ly, w, oldw] = bpnn_adjust_weights(delta, ndelta, ly, nly, w, oldw)
  ETA = 0.3;
  MOMENTUM = 0.3;
  mc_t104 = 1.0;
  mc_t105 = 1;
  ly(mc_t105) = mc_t104;
  mc_t107 = 2;
  for j = (mc_t107 : ndelta);
    mc_t106 = 1;
    for k = (mc_t106 : nly);
      mc_t100 = ETA;
      [mc_t101] = delta(j);
      [mc_t98] = times(mc_t100, mc_t101);
      [mc_t99] = ly(k);
      [mc_t94] = times(mc_t98, mc_t99);
      mc_t96 = MOMENTUM;
      [mc_t97] = oldw(k, j);
      [mc_t95] = times(mc_t96, mc_t97);
      [new_dw] = plus(mc_t94, mc_t95);
      [mc_t102] = w(k, j);
      mc_t103 = new_dw;
      [mc_t93] = plus(mc_t102, mc_t103);
      w(k, j) = mc_t93;
      oldw(k, j) = new_dw;
    end
  end
end
function [l1, l2] = bpnn_layerforward(l1, l2, conn, n1, n2)
  mc_t62 = 1.0;
  mc_t63 = 1;
  l1(mc_t63) = mc_t62;
  mc_t67 = 2;
  for j = (mc_t67 : n2);
    s = 0;
%sum
    mc_t64 = 1;
    for k = (mc_t64 : n1);
      mc_t55 = s;
      [mc_t57] = conn(k, j);
      [mc_t58] = l1(k);
      [mc_t56] = times(mc_t57, mc_t58);
      [s] = plus(mc_t55, mc_t56);
    end
    [mc_t61] = uminus(s);
    [mc_t60] = exp(mc_t61);
    mc_t65 = 1.0;
    [mc_t59] = plus(mc_t65, mc_t60);
    mc_t66 = 1.0;
    [mc_t54] = rdivide(mc_t66, mc_t59);
    l2(j) = mc_t54;
  end
end
function [errsum, delta] = bpnn_output_error(delta, target, output, nj)
  errsum = 0.0;
  mc_t92 = 2;
  [j] = colon(mc_t92, nj);
%mc_t88 = errsum;
  [o] = output(j);
  mc_t91 = 1.0;
  [t] = target(j);
  mc_t86 = o;
  [mc_t87] = minus(mc_t91, o);
  [mc_t85] = minus(t, o);
  [mc_t84] = times(mc_t86, mc_t87);
  [mc_t83] = times(mc_t84, mc_t85);
  delta(j) = mc_t83;
  [mc_t90] = delta(j);
  [mc_t89] = abs(mc_t90);
%[errsum] = plus(mc_t88, mc_t89);
  [mc_sum0] = sum(mc_t89);
  [errsum] = plus(errsum, mc_sum0);
end
