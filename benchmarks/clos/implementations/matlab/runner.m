function runner(scale)
%%
%% Driver for the transitive closure of a directed graph.
%%

N=450;

tic();
for time=1:scale
  B=closure(N);
end
elapsed = toc();

disp('{');
disp('"time":');
disp(elapsed);
disp('}');

end

