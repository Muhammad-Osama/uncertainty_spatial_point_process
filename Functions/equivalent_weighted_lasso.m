function [q_tilde, w_lasso, h_tilde] = equivalent_weighted_lasso (y, Phi, theta_tilde, Y)

%Let: 

%V(\theta) = -n^{-1}\ln p_{theta}(\bold{y}|\bold{r})

%f(theta) = ||w \odot \theta||_1

%h(theta_tilde) = [E_{theta_tilde}[y_1|r_1], ..., E_{theta_tilde}[y_n|r_n]]

%q(theta_tilde) = Phi*theta_tilde + Y.*(y-h(theta_tilde))

%Forms the equivalent weighted lasso problem:

%Q(\theta;\theta_tilde) + n^{-gamma}f(\theta) = Y(2n)^{-1} * 
%||q(theta_tilde)-Phi*theta||_{2}^{2} +  n^{-gamma}f(\theta) +
%K(theta_tilde) 

%where K(theta_tilde) = V(theta_tilde)-q(theta_tilde)

%Input:
%y: n x 1 vector of observed counts

%Phi: n x R basis matrix

%theta_tilde: R x 1 current estimate of theta

%Y: upper bound on the number of counts

%%

h_tilde = exp(Phi*theta_tilde);
 
w_lasso = Y.*ones(size(h_tilde));

q_tilde = Phi*theta_tilde + (1./w_lasso).*(y-h_tilde);