function y=showfeature(D,n,isplot)
% each row of D is a frame represented by a double vector.
% note that D must be in the same scale as the training data.
global SFA_STRUCTS;
addpath ../sfa_tk/sfa
addpath ../sfa_tk/lcov
load simulation_results.mat;
SFA_STRUCTS{1}=strct;
y=sfa_execute(1,D);
if isplot==1
x=1:100;
plot(x,y(:,1:n));
for i=1:n
    l{i}=num2str(i);
end
legend(l);
end