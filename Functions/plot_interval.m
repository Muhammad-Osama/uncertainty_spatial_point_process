function plot_interval(x,upp_cur,low_cur)
%% INPUT
%x: x- xaxis
%upp_cur : the upper limit
%low_cur: the lower limit
%%
figure;
fill([x;flipud(x)],[low_cur;flipud(upp_cur)],[0.5 0.5 0.5],'FaceAlpha',0.5);
