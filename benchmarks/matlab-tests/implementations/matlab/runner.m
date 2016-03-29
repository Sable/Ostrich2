function runner
    tic();
    arrayTests();
    dispTests();
    modTests();
    mrdivideTests();
    minusTests();
    mtimesTests();
    plusTests();
    relopTests();
    elapsedTime = toc();

    disp('{');
    disp('  "status": 1');
    disp('  ,"time":');
    disp(elapsedTime);
    disp('}');
end
