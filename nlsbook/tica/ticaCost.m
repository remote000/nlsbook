function [cost,grad]=ticaCost(W,data,P)
m=size(data,2);
wsize=round(sqrt(size(W,1)));
W=reshape(W,wsize,wsize);
grad=zeros(wsize,wsize);
for i=1:m
    Z=data(:,i);
    S=W*Z;
    E=P*(S.^2);
    C=h(E);
    cost=-sum(C);
    gE=g(E);
    A=-P'*gE;
    grad=grad+(A.*S)*Z';
end
grad=grad./m;
grad=grad(:);
end

function y=h(x)
    y=-2*sqrt(x+0.1);
end

function y=g(x)
    y=-(x+0.1).^(-0.5);
end