function drv_prime(scale)
    tic();
    n = numprime(scale);
    t = toc();

    disp('{');
    disp('"result":');
    disp(n);
    disp(', "time":');
    disp(t);
    disp('}');
end

