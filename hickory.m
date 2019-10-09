%% read data
%hickories data
data = csvread('C:\Osama_Uppsala\Spatial point process project\Real data\hickories.csv',1,0);
X1 = data(:,1); X2 = data(:,2);

K = 279.4; %(area of 279.47 x 279.47 m)

X1 = K.*X1; X2 = K.*X2; 

%plot of points
figure;
scatter(X1,X2,'kx'); xlabel('$x$','interpreter','Latex'); ylabel('$y$','interpreter','Latex');
grid on; hold on; title('Tree locations');

%% hexagonal grid
%Daimeter over which we approximate the intensity to be constant
D = 0.20*K; D = ceil(D);

%define hexagonal lattice: new data (Yobs, Xobs)
[y, r ,cen, rad, A]  = define_hex_lattice(X1,X2,D);

%% interpolation and/ extrapolation regions

ind = (r(:,1) > 0.60*K & r(:,2) < 0.30*K) | (r(:,1)>.20*K & r(:,1)<.50*K & r(:,2)>.60*K & r(:,2)<.90*K);

y_sub = y(~ind); r_sub = r(~ind,:);

%% basis
%nos. of neighbouring layers that basis should cover and corresponding
%support
nl = 3;
support = (rad + 2*nl*rad)*2;
%support = 7000;
[Phi, phiB] = define_basis(r_sub,cen,support);

%% fitting parameters
%rate of decrease of regularization
gamma = 0.499;  
%nos. of cycles of coordinate descent
L = 20; 
%upper bound on max possible counts in a cell
Y = 300;

md = 'reg';

%% fit
R = size(cen,1);

theta_tilda = randn(R,1); 

lic = index2update(Phi);

theta_reg = fit_regul_poisson(y_sub, Phi, gamma, Y, L, theta_tilda , lic);
%% Evaluate output quantities at grid resolution

%quantities at hexagon resolution
[~,lambda_hat] = eval_output_qaunt(cen, A, phiB, theta_reg);

%% plot intensity at hexagon level

plot_at_hex_res(lambda_hat,cen,R);
hold on; grid on;
scatter(X1,X2,'kx');
plot(K.*[20 50 50 20 20]./100,K.*[60 60 90 90 60]./100,'m--','LineWidth',1.5);
plot(K.*[60 100 100 60 60]./100,K.*[0 0 30 30 0]./100,'m--','LineWidth',1.5);
xlim(K.*[0 1]);
xlabel('$x_1~m$','interpreter','Latex');
ylabel('$x_2~m$','interpreter','Latex');
title('$\widehat{\lambda}(x)$','interpreter','Latex')

%% Prediction intervals
%confidence level
alpha = 0.2;

%maximum and minimum coutns
Yu = 1.5*Y; Yl = 0; 

[lambda_upp, lambda_low, ~, ~] = eval_conformal_pred_interval(alpha,Yu,Yl,y_sub,cen,lambda_hat,Phi,phiB,A,gamma,Y,L,theta_tilda,md);

%% plot prediction interval size at hex level
%Upper limit
temp = lambda_upp; 
temp(temp>0.1) = 0.1; %to make plot visually clearer 

plot_at_hex_res(temp, cen, R);
hold on; grid on;
plot(K.*[20 50 50 20 20]./100,K.*[60 60 90 90 60]./100,'m--','LineWidth',1.5);
plot(K.*[60 100 100 60 60]./100,K.*[0 0 30 30 0]./100,'m--','LineWidth',1.5);
xlim(K.*[0 1]);
caxis([0 0.1])
xlabel('$x_1~m$','interpreter','Latex');
ylabel('$x_2~m$','interpreter','Latex');
%%
%interval size
plot_at_hex_res(temp-lambda_low, cen, R);
hold on; grid on;
plot(K.*[20 50 50 20 20]./100,K.*[60 60 90 90 60]./100,'m--','LineWidth',1.5);
plot(K.*[60 100 100 60 60]./100,K.*[0 0 30 30 0]./100,'m--','LineWidth',1.5);
xlim(K.*[0 1]);
caxis([0 0.1])
xlabel('$x_1~m$','interpreter','Latex');
ylabel('$x_2~m$','interpreter','Latex');

%%
%lower limit
plot_at_hex_res(lambda_low, cen, R);
hold on; grid on;
plot(K.*[20 50 50 20 20]./100,K.*[60 60 90 90 60]./100,'m--','LineWidth',1.5);
plot(K.*[60 100 100 60 60]./100,K.*[0 0 30 30 0]./100,'m--','LineWidth',1.5);
xlim(K.*[0 1]);
caxis([0 0.1])
xlabel('$x_1~m$','interpreter','Latex');
ylabel('$x_2~m$','interpreter','Latex');
