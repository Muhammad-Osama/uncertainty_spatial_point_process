function [y,z] = predict_interv_hex(Y_aug, Z_aug, Phi_aug, gamma, Y, L, theta_tilda, zu , zl, ind, alpha, A,  md)

%Computes the upper/lower limit of the prediction interval in a particular
%region

%Input: 
%Y_aug: (n+1) x 1 augmented counts 
%Phi_aug: (n+1) x R augment basis matrix
%Z_aug: (n+1) x 1 augmented intensity
%gamma: rate in theorem \in (0, 0.5)  
%Y: upper bound on count 
%L: # of cycles of coordinate descent
%theta_tilda: (R x 1) initial estimate of thetta

%ind: ind==1:search for upper limit & ind==0: search for lower limit
%zu,zl: current upper and lower limits
%alpha: (1-alpha)\% coverage for interval
%A: area of hexagon

%---Method---&
%md = 1 regularized model in paper
%md = 0 unregularized 

%Output: 
%y,z: upper/lower limits of count and intensity respectively

%% 
n = length(Y_aug) - 1;

z_tilda = Z_aug(end);

lic = index2update(Phi_aug);

c = 1;
while c==1

%find new theta for augmented data  
if strcmp(md,'reg')==1
    theta_hat = fit_regul_poisson(Y_aug, Phi_aug, gamma, Y, L, theta_tilda, lic);
elseif strcmp(md,'ureg')==1
    theta_hat = fit_unreg_poisson(Y_aug, Phi_aug, gamma, Y,theta_tilda);
end
%predict intensity at all points in augmented data
lambda_hat = exp(Phi_aug*theta_hat)./A;

%inconsistency score
e = eval_inconsistency(Z_aug, lambda_hat);

%inconsistency rank of the added point
pi_tilda = compute_rank(e);

%find the new upper and lower limits based on half-interval search
[zu, zl, status] = half_interval_search(pi_tilda,ind,alpha,n,z_tilda,zu,zl);

%new point to add
[y, z] = new_point2augment(zu,zl,A);

%when to stop the half interval search
if (status==1 && abs(z-z_tilda)<0.05) 
   c = 0;
elseif status==0 && abs(z-z_tilda)<0.05
   c = 0;
else
   Y_aug(end) = y;
   Z_aug(end) = z;
   z_tilda = z;
end
    
end    
   