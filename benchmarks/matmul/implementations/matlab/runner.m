function runner(size)
    m=size;
    k=size/2;
    n=size;

    A = rand(m,k);
    B = rand(k,n);

    tic();
    matmul(A, B, m, k, n);
    t = toc();

    disp('{');
    disp('"options":');
    disp(size);
    disp(', "time": ');
    disp(t);
    disp('}');
end
