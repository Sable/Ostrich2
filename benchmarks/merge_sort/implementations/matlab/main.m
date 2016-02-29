function main(size)
    A = randn(1, size);
    tic();
    B = merge_sort(A, size);
    t = toc();
    ok = 1;
    for i = 1:size-1
        if B(i) > B(i+1)
            ok = 0;
            break;
        end
    end
    disp('{')
    disp('"options":')
    disp(size)
    disp(', "time":')
    disp(t)
    disp('}')
end

