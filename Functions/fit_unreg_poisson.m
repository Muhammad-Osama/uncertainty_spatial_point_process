function theta_unreg = fit_unreg_poisson(Y, Phi, rt, B,theta_tilda)

[N,D] = size(Phi);

p = sqrt(mean(Phi.^2,1))';

reg = N^(-rt);
%% without regularization

[loss_tilde,~] = eval_poisson_loss(Y,Phi,reg,p,theta_tilda);

while 1

%form the equivalent wieghted lasso problem with current theta
[z_tilde, w_tilde] = equivalent_weighted_lasso (Y, Phi, theta_tilda,B);

%solve the weighted regression problem and obtain new theta
W_tilde = diag(w_tilde);
theta_unreg = (Phi'*W_tilde*Phi+0.01.*eye(D))\(Phi'*W_tilde*z_tilde); 

[loss_new,~] = eval_poisson_loss(Y,Phi,reg,p,theta_unreg);

%check for convergence 
d = loss_tilde-loss_new;

%d = norm(theta_tilde-theta_new,2)/norm(theta_tilde,2);

if d<=0.005
    break;
else
    theta_tilda = theta_unreg;
    loss_tilde = loss_new;
end

end