%%%%%%%%linear_regression.m%%%%%%%%%%%
function theta=linear_regression(x,y)
m=size(x,1);
x=[ones(m,1),x];
A=x'*x;
b=x'*y;
theta=A\b;
end