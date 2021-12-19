function generate_hexagon(xc,yc,R)
%Draws a regular hexagon

%Inputs:
%(xc,yc): the coordinates of the centers of the hexagon
%R: The radius of the external circle of the hexagon

%Output:
%plot of single regular hexagon

%vertices
vert = zeros(7,2);

ang = [30 90 150 210 270 330 30];

for n=1:7
    vert(n,1) = xc + R*cosd(ang(n));
    vert(n,2) = yc + R*sind(ang(n));
end

plot(vert(:,1),vert(:,2),'b','LineWidth',2);
hold on;
scatter(xc,yc,100,'rx');
grid on;
