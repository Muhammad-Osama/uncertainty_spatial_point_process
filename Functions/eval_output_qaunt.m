function [avgCnt,lambda_hat] = eval_output_qaunt(cen,A,phiB,theta_reg)
%Compute output quantities at hexagons 

%Input
%(Xc,Yc): hexagon centers which identify the hexagon at which qauntities to
          %be computed
%R, A : Hexagon outer radius and area
%X1cm, X2cm, nl : basis parameters
%theta_reg: learned parameters from the fitting 

%Output:
%lambda_hat = Estimated intensity 
%%
[R,d] = size(cen);

avgCnt = zeros(R,1); lambda_hat = zeros(R,1); 

for nc = 1:R
    %average count in cell corresponding to point (Xe(n), Ye(n)) falls
    if d==1
        avgCnt(nc) = exp(phiB(cen(nc,1))*theta_reg);
    elseif d==2
        avgCnt(nc) = exp(phiB([cen(nc,1) cen(nc,2)])*theta_reg);
    end
    %intensity in the correponding cell
    lambda_hat(nc) = avgCnt(nc)/A; 
end

