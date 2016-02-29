function total = numprime(n)
    total = 0;
    for i = 2:n
        prime = 1;
        for j = 2:sqrt(i)
            if (mod(i,j) == 0)
                prime = 0;
                break;
            end
        end
        total = total + prime;
    end
end
