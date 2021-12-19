function [y, r, cen, rad, A]  = define_hex_lattice(X1,X2,D)

%Defines a hexagonal lattice over 2D space given point data with
%coordinates (X1,X2). Each hexagon is regular with outside diameter of D. 
%Also counts the number of points lying in each hexagon to get aggregated
%counts in each hexagon

%Input
%(X1,X2): coordinates of points, each n x 1 vector

%Output
%y: n x 1 vector of accumulated counts
%cen = [X1c, X2c] : centers of the hexagons in the hexagonal lattice
%r = [X1cm, X2cm] : centers of the hexagons in the hexagonal lattice in which the
              %accumulated counts Ym is not zero
%rad: radius of outer cirlce of hexagon R = D/2
%A : area of hexagon

%range of 2D space
mn = [min(X1) min(X2)]; mx = [max(X1) max(X2)];

%hexagon centers
[X1c,X2c,rad] = reg_hexagon_centers(mn,mx,D);

%Yt nos. of points in each hexagon
Y = assign_points2hexagon(X1,X2,X1c,X2c,rad);

%ignore hexagons with zero counts, new data is D = (y,X1cm,X2cm)
ind = Y==0;
y = Y(~ind); X1cm = X1c(~ind); X2cm = X2c(~ind);

%regular hexagon area and radius
A = 3*sqrt(3)/2*rad^2;

r = [X1cm X2cm]; cen = [X1c X2c]; 
