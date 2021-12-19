function plot_hex_latt(cen,R)
%plots the hexagonal lattice

%Inputs:
%(Xc, Yc): centers of all hexagons
%R: The radius of the external hexagon circle

for n=1:size(cen,1)
   generate_hexagon(cen(n,1),cen(n,2),R) 
end

axis square;