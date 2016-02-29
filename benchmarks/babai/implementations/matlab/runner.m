function runner(size)
	R = triu(randn(size));
	Y = randn(size, 1);
	tic;
	[vec] = babai(R, Y);
	elapsedTime = toc;
  svec = sprintf('%f', vec);
	disp('{ "status": 0, "options": "runner(%s)", "time": %f,  "output": "%s" }\n', num2str(size), elapsedTime, svec);
end
