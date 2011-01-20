
nimg=13;
patchsize=32;
inputsize=patchsize*patchsize;
c1=5000;
c2=20;
%get whitening matrix
X=sampleimages(patchsize,sample_per_img);
[Z,V]=whitening(X);
%prepare training images
 for i=1:nimg
        str=['data/' num2str(i) '.tiff'];
        image=imread(str);
        image=double(image);
        imgs{i}=image;
 end
for i1=1:c1
    nig=randi(nimg);
    image=imgs{nig};
    ncols=size(image,2);
    nrows=size(image,1);
    pcol=randi(ncols-patchsize+1);
    prow=randi(nrows-patchsize+1);
    for i2=1:c2
        %
        
    end
end