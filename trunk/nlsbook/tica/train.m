%debug=1;
initializing;
addpath minFunc/
options.Method = 'lbfgs';
options.maxIter = 500;
options.display = 'on';
[opttheta, cost] = minFunc(@(w) ticaCost(w,Z,P),theta,options); 
W=reshape(opttheta,fsize,fsize);
W=W*V(1:fsize,:);
A=pinv(W);
display_network(A);
