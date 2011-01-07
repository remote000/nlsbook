function Y=divisive_normalize(X)
    pnorm=sum(X.^2);
    sorted=sort(pnorm,'ascend');
    epsilon=sorted(round(size(X,2)/10));
    Y=X.*((ones(size(X,1),1)*pnorm+epsilon).^-0.5);
end