 function [Xc,Yc,R] = reg_hexagon_centers(mn,mx,D)
%Computes the center of hexagons over R^2
 
%Input: 
%mn = [min(x) min(y)]; 
%mx = [max(x) max(y)];
%D: Diameter over which we can assume the intersity to be approximately constant 
%and also get enough data points within (problem specific)

%Output:
%XC,YC: centers of hexagons

%hexagon parameters
R = D/2; r = R*cosd(30); 

%distance between centers along y and x
ystp = 1.5*R; xstp = 2*r;

%upper and lower limits along y and x
ly = mn(2); uy = ceil((mx(2)-mn(2))/ystp)*ystp + mn(2); 
lx = mn(1); ux = ceil((mx(1)-mn(1))/xstp)*xstp + mn(1); 

%y-coordinates of centers
yc = (ly:ystp:uy)';
Nyc = length(yc);

%x-coordinates of centers
xc1 = (lx:xstp:ux)'; xc2 = xc1+r; xc2 = xc2(1:end-1);
Xc = []; Yc = [];
for n = 1:Nyc
   if rem(n,2)~=0
       Xc = [Xc; xc1];
       Yc = [Yc; repmat(yc(n),length(xc1),1)]; 
   elseif rem(n,2)==0
       Xc = [Xc;xc2];
       Yc = [Yc; repmat(yc(n),length(xc2),1)];
   end
end

