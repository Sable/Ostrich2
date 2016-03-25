function runner
    tic();
    dispTests();
    mtimesTests();
    elapsedTime = toc();

    disp('{');
    disp('  "status": 1');
    disp('  ,"time":');
    disp(elapsedTime);
    disp('}');
end
