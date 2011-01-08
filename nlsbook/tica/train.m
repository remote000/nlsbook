%debug=1;
%initializing;
fprintf('initializing neighbour map and initial W\n'); 
fsize=size(Z,1);
m=size(Z,2);
W=rand(fsize,fsize);
W=real((W*W')^-0.5)*W;
P=getNeighbourMap(fsize,neighbourdist);
theta=W(:);

addpath minFunc/
options.Method = 'lbfgs';
options.maxIter = 800;
options.display = 'on';
[opttheta, cost] = minFunc(@(w) icaCost(w,Z,P),theta,options); 
W=reshape(opttheta,fsize,fsize);
W=W*V(1:fsize,:);
A=pinv(W);
display_network(A);
