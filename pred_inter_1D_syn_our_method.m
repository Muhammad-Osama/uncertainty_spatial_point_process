%% Description

%Find the point estimate for intensity function and the (1-alpha)\% 
%conformal prediction interval using REGULARIZED and UNREGULARIZED
%The true intensity \lambda(x) is a decaying exponetial.
%Point data is generated from a poisson point process with intensity
%\lambda(x) by using inversion sampling
%space is 1D [0,100], divided into Nbins = 50 regions
%count 'y' in each region is the sum of the point falling in that region
%TWO scenarios: interpolation [30, 80] and extrapolation [70, 100]
%considered
%----
%plots the true \lambda(x), the point estimate of intensity and the
%conformal prediction interval

%% set the seed
stream = RandStream('mt19937ar','Seed',0);
RandStream.setGlobalStream(stream);
savedState=stream.State;

%% underlying intensity function
%intensity
alpha = 5; beta = 50;
lambda = @(x) alpha.*exp(-x./beta);

%spatial limits
mn = 0;  mx = 150;

xs = mn:0.1:mx;

%average counts over spatial limits
W = (1-exp(-mx/beta))*alpha*beta;

%corresponding pdf
f = @(x) lambda(x)./W;

%corresponding i-cdf for inverse sampling
Finv = @(u) -beta.*log(1-u.*(1-exp(-mx/beta)));

%% Simulate coordinates of events

N = poissrnd(W);

xsamples = zeros(N,1);

for n=1:N
    u = rand(1);
    xsamples(n) = Finv(u);
end
%% plot
figure;
plot(xs,lambda(xs),'r','LineWidth',2); grid on; hold on;
xlabel('$x$','interpreter','Latex');
ylabel('$Intensity$','interpreter','Latex')
scatter(xsamples,zeros(N,1),'kx');
legend({'$\lambda(x)$','Events'},'interpreter','Latex')

%% Bins and get new data {yp,xcp}_i=1^Nbin

Nbins = 30; xedge = linspace(mn,mx,Nbins+1);

%area of bin
A = xedge(2)-xedge(1);

%count events in each bin
Y = zeros(Nbins,1); cen = zeros(Nbins,1);

for nbin=1:Nbins
    cen(nbin) = (xedge(nbin)+xedge(nbin+1))/2;
    Y(nbin) = sum(xsamples>=xedge(nbin) & xsamples<=xedge(nbin+1));
end

%discard bins with no counts
ind =  (cen>=50 & cen<=100) ;

 y = Y(~ind);
%y = Y;
% 
 r = cen(~ind);
%r = cen;

%%
ind1 = (xsamples>=50 & xsamples<=100);

%scatter(xsamples(~ind1),zeros(sum(~ind1),1),'kx');
%hold on;

%% basis
support = 140;
[Phi, phiB] = define_basis(r,cen,support);

%% parameters for fitting
%rate of decrease of regularization
gamma = 0.499;  
%nos. of cycles of coordinate descent
L = 20; 
%upper bound on max possible counts in a cell
Y = 100;

%% coeffs. to compute
lic = index2update(Phi);

%% fit

md = 'reg';

R = size(cen,1);

theta_tilda = randn(R,1);

if strcmp(md, 'reg')==1
    theta = fit_regul_poisson(y, Phi, gamma, Y, L, theta_tilda , lic);
elseif strcmp(md ,'ureg')==1
    theta = fit_unreg_poisson(y,Phi,gamma,Y,theta_tilda);
end
    
%% eval output quantities

Y0 = 5; a1 = 0.25;

[~,lambda_hat] = eval_output_qaunt_1D(cen,A,phiB,theta);

%%
%plot_intensity_1D(lambda_hat, xedge,1)

%% Prediction intervals
%confidence level
alpha = 0.2;

%maximum and minimum counts
Yu = 800; Yl = 0; 

[lambda_upp, lambda_low, ~ , ~] = eval_conformal_pred_interval(alpha,Yu,Yl,y,cen,lambda_hat,Phi,phiB,A,gamma,Y,L,theta_tilda,md);

%%

[z_uppf,xax] = plot_intensity_1D(lambda_upp, xedge,0);
   
[z_lof,xax] = plot_intensity_1D(lambda_low, xedge,0);
%%
figure;

plot(xs,lambda(xs),'r','LineWidth',2); grid on; hold on;
hold on;
scatter(xsamples(~ind1),zeros(sum(~ind1),1),'kx');
hold on;
plot_intensity_1D(lambda_hat, xedge,1)
hold on;
fill([xax;flipud(xax)],[z_lof;flipud(z_uppf)],[0.5 0.5 0.5],'FaceAlpha',0.5);
 
plot([50 50],[0 12],'m-')

plot([100 100],[0 12],'m-')

title('$Our~method$','interpreter','Latex');

xlabel('$x$','interpreter','Latex');

legend({'$\lambda(x)$','Events','$\widehat{\lambda}(x)$','$\Lambda_{\alpha}(x)$'},'interpreter','Latex');
