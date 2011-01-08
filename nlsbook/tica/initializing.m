sample_per_img=1000;
debug=1;
patchsize=32;
X=sampleimages(patchsize,sample_per_img);
neighbourdist=2;
fprintf('whitening input...\n');
[Z,V]=whitening(X);

