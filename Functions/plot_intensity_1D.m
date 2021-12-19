function [intensity,xs] = plot_intensity_1D(inten, xedge,opt)
%INPUT
%inten: quanity on y-axis
%xedge: quanity on x-axis
%opt: 1 means plot, 0 means do not plot

%OUTPUT
%intensity : piecewise constant intensity
%xs: new x-axis to plot output intensity against

mn = min(xedge); mx = max(xedge);

xs = (mn:0.1:mx)';

intensity = zeros(length(xs),1);

for n=1:length(intensity)
   ind =  point_which_bin1D(xs(n),xedge);
   intensity(n) = inten(ind);
end

if opt==1
plot(xs,intensity,'b--','LineWidth',1.5);
end
