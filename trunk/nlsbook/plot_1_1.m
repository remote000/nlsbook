%%%%%%%plot_1_1.m%%%%%%%%%%
load q1x.dat;
load q1y.dat;
theta=logistic_newton(q1x,q1y);
x1max=max(q1x(:,1));
x1min=min(q1x(:,1));
step=(x1max-x1min)/100.0;
m=size(q1x,1);
x1=x1min:step:x1max;
x2=-theta(1)/theta(3)-theta(2)/theta(3).*x1;
figure; 
hold on;
plot(x1,x2);
for i=1:m
    if(q1y(i)==0)
        plot(q1x(i,1),q1x(i,2),'b+');
    else
        plot(q1x(i,1),q1x(i,2),'ro');
    end
end
xlabel('x1');
ylabel('x2');