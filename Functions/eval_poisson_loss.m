function [loss, loss_reg] = eval_poisson_loss(y,Phi,reg,p,theta)

N = length(y);

lambda = exp(Phi*theta);

log_y = @(y) sum(log(y:-1:2));

loss = 0; 

for n = 1:N
   loss = loss + lambda(n)-y(n)*log(lambda(n))+log_y(y(n));
end
loss = 1/N*loss;

loss_reg = loss + reg*norm(p.*theta,1);
