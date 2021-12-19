function plot_at_hex_res(yhat,cen, R)


mn = [min(cen(:,1)) min(cen(:,2))]; 

mx = [max(cen(:,1)) max(cen(:,2))];

x1 = linspace(mn(1),mx(1),50);

x2 = linspace(mn(2),mx(2),50);

[X1,X2] = meshgrid(x1,x2);

sz = size(X1); 

X1 = X1(:); X2 = X2(:);

yhat_m = zeros(length(X1),1);

for n = 1:length(X1)
    for nc = 1:size(cen,1)
        ind = check_whether_inside_hexagon(X1(n),X2(n),cen(nc,1),cen(nc,2),R);
        if ind==1
                yhat_m(n) = yhat(nc);
            break;
        end
    end
end

X1 = reshape(X1,sz); X2 = reshape(X2,sz); yhat_m = reshape(yhat_m,sz);

figure;
contourf(X1,X2,yhat_m); colorbar; 
axis square;


