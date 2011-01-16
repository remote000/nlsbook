alpha=0.01;
nimg=13;
patchsize=32;
inputsize=patchsize*patchsize;
c1=5000;
c2=20;
%get whitening matrix
fprintf('computing whitening matrix');
Xx=sampleimages(patchsize,1000);
[Zz,V]=whitening(Xx);
%prepare training images
 for i=1:nimg
        str=['data/' num2str(i) '.tiff'];
        image=imread(str);
        image=double(image);
        imgs{i}=image;
 end
%initialize parameters
zsize=size(V,1);
W=rand(zsize,zsize);
W=real((W*W')^-0.5)*W;
K=rand(2,zsize);
%training
for i1=1:c1
    nig=randi(nimg);
    image=imgs{nig};
    %initial feedforward
    ncols=size(image,2);
    nrows=size(image,1);
    pcol=randi(ncols-patchsize+1);
    prow=randi(nrows-patchsize+1);
    I=reshape(image(prow:prow+patchsize-1,pcol:pcol+patchsize-1),inputsize,1);
    Z=V*I;
    S=W*Z;
    Ctr=K*S;
    %Sft=tanh(Ctr);
    E=S.^2;
    G=2*sqrt(E+0.1);
    dW=zeros(size(W));
    dK=zeros(size(K));
    for i2=1:c2
        %shift the input
        prow=prow+sign(Ctr(1))*round(abs(Ctr(1)));
        pcol=pcol+sign(Ctr(2))*round(abs(Ctr(2)));
        I=reshape(image(prow:prow+patchsize-1,pcol:pcol+patchsize-1),inputsize,1);
        %feedforward
        Z=V*I;
        S_old=S;
        S=W*Z;
        Ctr_old=Ctr;
        Ctr=K*S;
        E=S.^2;
        %backpropagation
        dE=(E+0.1).^(-0.5);
        dS=2*S.*dE;
        dW=dW+dS*Z';
        dZ=W'*dS
        dI=V'*dZ;
        %calculate dCtr
        gradCtr1=(image(prow+1:prow+patchsize,pcol:pcol+patchsize-1)-image(prow-1:prow+patchsize-2,pcol:pcol+patchsize-1))/2;
        gradCtr1=gradCtr1(:);
        gradCtr2=(image(prow:prow+patchsize-1,pcol+1:pcol+patchsize)-image(prow:prow+patchsize-1,pcol-1:pcol+patchsize-2))/2;
        gradCtr2=gradCtr2(:);
        dCtr=[0;0];
        dCtr(1)=gradCtr1*dI;
        dCtr(2)=gradCtr2*dI;
        %dCtr=?;
        dK=dK+dCtr*S_old';   
    end
    W=W-alpha*dW/c2;
    K=K-alpha*dK/c2;
end

