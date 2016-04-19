function runner(size)
    x = 0;
    y = 0;
    tic();
    for i=1:size
        x = x + commonRandomJS();
    end
    elapsedTime = toc();
    y = commonRandomJS();

    disp('{');
    disp('"options":');
    disp(size);
    disp(', "time":');
    disp(elapsedTime);
    disp(', "output":');
    disp(y); 
    disp('}');

end
