function runner(size)

tic();
max_length = 0;
max_num = 0;
for i = 1:size
    length = collatz(i);
    if length > max_length
        max_length = length;
        max_num = i;
    end
end
elapsedTime = toc();

disp('{')
disp('"options":')
disp(size)
disp(', "time":')
disp(elapsedTime)
disp('}')

%disp('OUT');
%disp(max_num);
%disp(max_length);

end
