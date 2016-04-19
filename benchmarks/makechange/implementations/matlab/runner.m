function runner(scale)
    coins = [1 5 10 25];
    tic();
    for i = 0:scale
        make_change(coins, 4, i);
    end
    elapsed = toc();

    disp('{');
    disp('"time":');
    disp(elapsed);
    disp('}');
end
