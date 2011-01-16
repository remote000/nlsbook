% track obama's nose
% 1, download video in mp4 format from youtube via keepVid
% 2, convert mp4 to MJPEG by Pazera Free
% 3, open MJPEG by VirtualDub, save it as avi
% aviread should be able to work now.
data=aviread('data/oba2.avi',1:300);
d=data(1).cdata(:,:,2);
dd=double(d);
imshow(dd,[0,255]);
%mask the nose in the first frame
mask=ones(size(dd));
mask(65:77,130:150)=0;