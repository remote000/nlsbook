%%%%%%%%%plot_1_2d2.m%%%%%%%
load q2x.dat
load q2y.dat
tao=[0.1,0.3,0.8,2,10];
x1max=max(q2x);
x1min=min(q2x);
step=(x1max-x1min)/100.0;
x=x1min:step:x1max;
n=size(x,2);
m=size(tao,2);
y=zeros(n,m);
for j=1:m
    for i=1:n
        y(i,j)=local_weighted_LR(x(i),q2x,q2y,tao(j));
    end
end
figure;
hold on;
plot(q2x,q2y,'.',x,y,'-');
legend('training data','tau=0.1','tau=0.3','tau=0.8','tau=2','tau=10');
xlabel('x');
ylabel('y');