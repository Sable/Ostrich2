function runner(scale)
%DRV_PN_LEGENDRE_VECTN Summary of this function goes here
%   Detailed explanation goes here

x=[0 0.3 0.9 0.7 0.5];
n=5;

tic();
for i=1:scale
    lgdr(x,n);
end
elapsed = toc();

disp('{');
disp('"time":');
disp(elapsed);
disp('}');

end
