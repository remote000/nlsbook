%%%%%%%%logistic_newton.m%%%%%%%%%
function theta=logistic_newton(x,y)
[m,n]=size(x);
x=[ones(m,1),x];
theta=zeros(n+1,1);
theta_old=theta-1;
while norm(theta-theta_old)>1e-6
    H=zeros(n+1,n+1);
    h=sigmoid(x*theta);
    c=-h.*(1-h);
    grad=x'*(y-h);
    for i=1:m
        for j=1:n+1
            for k=1:n+1
                H(j,k)=H(j,k)+x(i,j)*x(i,k)*c(i);
            end
        end
    end
    theta_old=theta;
    theta=theta-H\grad;
end