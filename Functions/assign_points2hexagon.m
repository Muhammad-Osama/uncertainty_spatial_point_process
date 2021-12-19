function [Yt] = assign_points2hexagon(X,Y,Xc,Yc,R)

Nc = length(Xc);

N  = length(X);

%nos. of points inside each cell
Yt = zeros(Nc,1);

lic = ones(N,1); lic = lic<0;

for nc=1:Nc 
    for n = 1:N
        if lic(n)== 0
            ind = check_whether_inside_hexagon(X(n),Y(n),Xc(nc),Yc(nc),R);
            if ind == 1
                Yt(nc) = Yt(nc)+ind;
                lic(n) = ind;
            end
        else
            continue;
        end
    end
end

% ind = Yt==0;
% 
% Yt = Yt(~ind); Xcm = Xc(~lic); Ycm = Yc(~ind);