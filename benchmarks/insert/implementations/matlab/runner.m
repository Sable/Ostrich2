function runner(size)

A=(randn(1,size));
A=100*A;
tic();
y=insertion_sort(A, length(A));
elapsedTime = toc();

disp('{')
disp('"options":')
disp(size)
disp(', "time":')
disp(elapsedTime)
disp('}')

end
