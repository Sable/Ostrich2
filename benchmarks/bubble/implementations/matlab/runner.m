function runner(size)

A=(randn(1,size));
A=100*A;
tic;
y=bubble(A);
elapsedTime = toc;

%fprintf(1, '{ \"status\": 1, \"options\": \"%d\", \"time\": %f }\n', size, elapsedTime);
disp('{')
disp('"options":')
disp(size)
disp(', "time":')
disp(elapsedTime)
disp('}')

end
