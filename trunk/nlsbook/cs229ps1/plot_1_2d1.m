%%%%%%%%%%plot_1_2d1.m%%%%%%%
load q2x.dat
load q2y.dat
theta=linear_regression(q2x,q2y);
x1max=max(q2x);
x1min=min(q2x);
step=(x1max-x1min)/100.0;
m=size(q1x,1);
x=x1min:step:x1max;
y=theta(1)+theta(2).*x;
plot(q2x,q2y,'o',x,y,'-r');
xlabel('x');
ylabel('y');