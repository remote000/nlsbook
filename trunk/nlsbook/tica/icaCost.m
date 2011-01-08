function [cost,grad]=ticaCost(W,data,P)
m=size(data,2);
wsize=round(sqrt(size(W,1)));
W=reshape(W,wsize,wsize);
grad=zeros(wsize,wsize);
cost=0;
%% a clear version of feedforward-backpropagation process
% for i=1:m
%     Z=data(:,i);
%     %feedforward
%     S=W*Z;
%     E=(S.^2);
%     
%     C=h(E);
%     cost=cost+sum(C);
%     %backpropagating
%     dC=ones(size(C));
%     dE=g(E).*dC;
%     
%     dS=2*S.*dE;
%     dW=dS*Z';
%     grad=grad+dW;
% end
%% a compact version
%feedforward
S=W*data;
E=S.^2;
C=h(E);
cost=cost-sum(sum(C))/m;
%backpropagation
dE=g(E);
dS=2*S.*dE;
dW=dS*data';
grad=grad-dW/m;
a=log(det(W));
cost=cost-a;
grad=grad-inv(W)';
%grad=grad-W*grad'*W;
grad=grad(:);
end

function y=testh(x)
    y=-x.*x;
end
function y=testg(x)
    y=-2*x;
end

function y=h(x)
    y=-2*sqrt(x+0.1);
end

function y=g(x)
    y=-(x+0.1).^(-0.5);
end