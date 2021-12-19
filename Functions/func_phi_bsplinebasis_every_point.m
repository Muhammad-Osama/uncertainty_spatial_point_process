function [Phi,cen] = func_phi_bsplinebasis_every_point(x,support,cen)
%% Phi(x) - using cubic Bspline with rectangular boundaries
% x row vector R^D
% mn row vector R^D
% mx row vector R^D
% M the total number of supports in R^2

%% Initialize
%D   = size(x,2);
%Phi = ones(1,(M^D));
%nos. of centers
M = size(cen,1);
Phi = ones(1,M);
D = length(x);

%% Construct Phi
for c = 1:M
    for d=1:D
        Phi(c) = Phi(c) * cubic_bspline_at_point(x(d),cen(c,d),1,4/(support));
    end
end

end

