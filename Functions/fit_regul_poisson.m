function [theta_hat, q_tilde, w_lasso]  = fit_regul_poisson(y, Phi, gamma, Y, L, theta_tilde, lic)

%Let: 

%V(\theta) = -n^{-1}\ln p_{theta}(\bold{y}|\bold{r}), 

%f(\theta) = ||w \odot \theta||_1

%solves: 

%theta_hat = \argmin_{\theta} [V(\theta)  + n^{-gamma}f(\theta)]

%Input
%Y: n x 1 vector {Y_i}_{i=1}^{N} of observed counts in hexagons 

%Phi:n x R basis matrix with each row equal to phi(i)^T

%rt: rate of regularization parameter

%p: R x 1 vector of the weights of individual theta in the l_1 penalty

%B: scalar upperbound on the maximum average nos. of counts in a

%theta_tilde: R x 1 vector of initial estimate of theta

%lic: R x 1 logical vector which is equal to '1' for those parameters that

%are to be updatad

%Output

%theta_hat: R x 1 vector of estimated model parameters theta 

n = length(y);

%% fitting parameters
%weights
w = sqrt(mean(Phi.^2,1))';

%minimum weight
%w0 = min(abs(p)); c = w0; 

%t = c/(N^alph); 

%regularization constant
reg = n^(-gamma);

%% fit

%calculates loss at initial estimate theta_tilde
[~,loss_tilde] = eval_poisson_loss(y,Phi,reg,w,theta_tilde);

while 1

%form the equivalent weighted lasso problem with current theta
[q_tilde, w_lasso] = equivalent_weighted_lasso (y, Phi, theta_tilde, Y);

%solve the weighted lasso problem and obtain new theta
theta_check = weighted_lasso_reg(q_tilde, Phi, w_lasso, reg, w, L, lic);

[~,loss_check] = eval_poisson_loss(y,Phi,reg,w,theta_check);

%check for convergence 
df = loss_tilde-loss_check;

if df<=0.009
    break;
else
    theta_tilde = theta_check;
    loss_tilde = loss_check;
end

end

theta_hat = theta_check;
