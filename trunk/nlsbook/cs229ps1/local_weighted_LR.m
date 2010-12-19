%%%%%%%%local_weighted_LR.m%%%%%%%%%%
function qy=local_weighted_LR(qx,x,y,tao)
%for each training sample, compute the weight w
m=size(x,1);
x=[ones(m,1),x];
w=eye(m);
for i=1:m
    w(i,i)=exp(-(qx-x(i,2))*(qx-x(i,2))/(2*tao*tao));
end
theta=(x'*w*x)\x'*w*y;
qy=[1,qx]*theta;
end