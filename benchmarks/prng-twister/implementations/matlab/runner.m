function runner(size)
    rng(1337, 'twister');
    x = 0;
    y = 0;
    tic();
    x = rand([1,size]);
    elapsedTime = toc();
    y = rand();

    disp('{');
    disp('"options":');
    disp(size);
    disp(', "time":');
    disp(elapsedTime);
    disp(', "output":');
    disp(y); 
    disp('}');
end
