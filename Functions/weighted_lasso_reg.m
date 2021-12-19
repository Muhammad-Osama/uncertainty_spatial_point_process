function theta_hat = weighted_lasso_reg(q_tilde, Phi, w_lasso, reg, w, L, lic) 

%Solves the weighted lasso regression problem:

%\argmin_{\theta} [Y(2n)^{-1} * ||q(theta_tilde)-Phi*theta||_{2}^{2} +  
% n^{-gamma}f(\theta) + K(theta_tilde)]

%Input:
%q_tilde : q(theta_tilde) from weighted lasso 

%Phi: n x R basis matrix

%w_lasso: n x 1 vector of weights for the weighted lasso problem

%w: R x 1 weights in the regularization term of the penalty

%L: # of cycles for the coordinate descent algorithm

%lic: R x 1 logical vector which is 1 for the coefficients to be updated
%%
[n,R] = size(Phi);

theta_hat = zeros(R,1);

for l=1:L
    
    for d=1:R
        
        if lic(d)==1 %recompute only some coefficients
            
            r  = q_tilde - Phi*theta_hat + Phi(:,d)*theta_hat(d);
        
            beta = 1/n * (w_lasso.*r)' * Phi(:,d);
        
            alpha = 1/n * (w_lasso.*Phi(:,d))'*Phi(:,d);
        
            m_reg = reg*w(d);
        
            if alpha>10e-7
            
            if beta> m_reg
                theta_hat(d) = (beta - m_reg)/alpha;

            elseif beta < -m_reg

                theta_hat(d) = (beta + m_reg)/alpha;
            end
        
            end    
        end
    end

end