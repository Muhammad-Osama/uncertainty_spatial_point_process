function [Phi, phiB] = define_basis(r,cen,support)

%Computes basis matrix

%Input: Xobs: n x d matrix of centers of hexagons where data is observed
%       cen: R x d matrix of centers of all hexagons covering space
%       support: scalar in units of distance defining the neighbourhood

%Output: Phi: n x R basis matrix 
%        phiB: basis handle for evaluating at some new point
n = size(r,1);

R = size(cen,1);

Phi = zeros(n,R);

phiB = @(x) func_phi_bsplinebasis_every_point(x,support,cen);

for i = 1:n
   Phi(i,:) = phiB(r(i,:));  
end