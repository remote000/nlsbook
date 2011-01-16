function [Z,V]=whitening(X)
    nrow=size(X,1);
    Z=X-ones(nrow,1)*mean(X);
    covm=Z*Z'/size(Z,2);
    [Q,D]=eig(covm);
    [d2,order]=sort(diag(D),'descend');
    d2=d2.^-0.5;
    Q=Q(:,order);
    V=diag(d2)*Q';
    Z=V(1:nrow/4,:)*Z;
end