function runner(size)
	R = randn(size);
	Y = randn(size, 1);
	tic();
	[vec] = babai(R, Y);
	elapsedTime = toc();
    disp('{');
    disp('"options": ');
    disp(size);
    disp(',"time":');
    disp(elapsedTime);
    %disp(',"output:');
    %disp(vec);
    disp('}');
    %svec = sprintf('%f', vec);
	%disp('{ "status": 0, "options": "runner(%s)", "time": %f,  "output": "%s" }\n', num2str(size), elapsedTime, svec);
end
