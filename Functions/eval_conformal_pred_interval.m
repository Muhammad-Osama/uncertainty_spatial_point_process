function [z_upp, z_low, y_upp, y_low] = eval_conformal_pred_interval(alpha,Yu,Yl,y,cen,lambda_hat,Phi,phiB,A,gamma,Y,L,theta_tilda,md)

%Evaluate conformal prediction intervals with (1-alpha\%) coverage

%Input:
%-----For conformal interval------%

%Yu : Upper limit of counts 'y' for evaluation in conformal prediction
%Yl : Lower limit of counts 'y' for evaluation in conformal prediction
%y: n x 1 vector of observed counts
%cen  : n x 1 vector of coordinates of the centers of the 'n' regions in
%which data is observed
%lambda_hat: R x 1 vector of estimated intensity for the 'R' regions
%alpha : (1-alpha)\% covergae conformal interval

%-----For fitting-----%
%gamma: (0, 0.5) in theorem 1
%Y : Upper bound on count 'y'
%L : # of cycles of coordinate descent
%theta_tilda: R x 1 vector of initial estimate of theta 

%----Other-----%
%Phi : n x R basis matrix
%phiB : basis function handle
%A : area of regions (same for all regions)

%---Method---&
%md = 'reg' regularized model in paper
%md = 'unreg' unregularized 

%Output:
%z_upp: R x 1 vector of upper limit of intensity for the 'R' regions
%z_low: R x 1 vector of lower limit of intensity for the 'R' regions
%y_upp: corresponding upper limit on counts
%y_low: corresponding lower limit on counts

%%
z_upp = zeros(size(cen,1),1); z_low = zeros(size(cen,1),1); 

y_upp = z_upp; y_low = z_low;

%for loop over different regions
for i = 1:length(cen)
    i
    %add in hexagon with center
    x_tilda = cen(i,:);
  
    %upper limit
    ind = 1;
    zl = lambda_hat(i); zu = Yu/A;
    %add count
    [y_tilda, z_tilda] = new_point2augment(zu,zl,A);
    %augmented data
    [Y_aug, Z_aug, Phi_aug] = augmented_data(y_tilda,z_tilda,x_tilda,y,Phi,phiB,A);
    %find upper limit
    [y_upp(i),z_upp(i)] = predict_interv_hex(Y_aug, Z_aug, Phi_aug, gamma, Y, L, theta_tilda, zu , zl, ind, alpha, A, md);
    
    %lower limit
    ind = 0;
    zl = Yl/A; zu = lambda_hat(i);
    %add count
    [y_tilda, z_tilda] = new_point2augment(zu,zl,A);
    %augmented data
    [Y_aug, Z_aug, Phi_aug] = augmented_data(y_tilda,z_tilda,x_tilda,y,Phi,phiB,A);
    %find lower limit
    [y_low(i),z_low(i)] = predict_interv_hex(Y_aug, Z_aug, Phi_aug, gamma, Y, L, theta_tilda,zu , zl, ind, alpha, A,md);

end