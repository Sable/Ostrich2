function drv_diff(scale)
%%
%% Driver for the diffraction pattern calculator.
%%

CELLS=2;
SLITSIZE1=1e-5;
SLITSIZE2=1e-5;
T1=1;
T2=0;

tic;
for time=1:scale
    mag=diffraction(CELLS, SLITSIZE1, SLITSIZE2, T1, T2);
end
elapsedTime = toc;

disp('The elapsed time (s):');
disp(elapsedTime);

%fprintf(1, '{ "status": 0, "options": "runner(%s)", "time": %f }\n', num2str(size), elapsedTime);

end
