function runner(scale)
tic();
mcpi_p(scale,50000);
elapsed = toc();
disp('{');
disp('"time":');
disp(elapsed);
disp('}');
end


