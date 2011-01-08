function W=ticatrain(Z,P)
fsize=size(Z,1);
m=size(Z,2);
W=rand(fsize,fsize);
W=real((W*W')^-0.5)*W;
for it=1:1000
    fprintf('iteration:%d\n',it);
    S=W*Z;
    E=P*(S.^2);

    dQ=P'*g(E);
    dS=2*S.*dQ;
    dW=dS*Z'/m;
    
    dW=dW-W*dW'*W;
    Wold = W;
    W = W + mu*grad;
    

end
end

function y=g(x)
    y=-(x+0.1).^(-0.5);
end