% track obama's nose
% 1, download video in mp4 format from youtube via keepVid
% 2, convert mp4 to MJPEG by Pazera Free
% 3, open MJPEG by VirtualDub, save it as avi
% aviread should be able to work now.
data=aviread('data/oba2.avi',1:300);
%d=rgb2gray(data(1).cdata);
dd=data(1).cdata;
%dd=double(d);

xrange=35:110;
yrange=123:168;

dd(xrange(1)-1,yrange(1)-1:yrange(end)+1,:)=0;
dd(xrange(end)+1,yrange(1)-1:yrange(end)+1,:)=0;
dd(xrange(1)-1:xrange(end)+1,yrange(1)-1,:)=0;
dd(xrange(1)-1:xrange(end)+1,yrange(end)+1,:)=0;
%imshow(dd);
%pause;
mov(1)=im2frame(uint8(round(dd)));

dprev=dd(xrange,yrange,:);
dprev=dprev(:);
idx=zeros(300,1);
idy=zeros(300,1);
for nd=2:300
    dd=data(nd).cdata;
    %dd=double(d);
    normmin=1e6;
    for i=-5:5
        for j=-10:10
            dnow=dd(xrange+i,yrange+j,:);
            dnow=dnow(:);
            normd=norm(double(dnow)-double(dprev));
            if normd<normmin
                normmin=normd;
                imin=i;jmin=j;
            end
        end
    end
    idx(nd)=imin;
    idy(nd)=jmin;
    xrange=xrange+imin;
    yrange=yrange+jmin;
    dd(xrange(1)-1,yrange(1)-1:yrange(end)+1,:)=0;
    dd(xrange(end)+1,yrange(1)-1:yrange(end)+1,:)=0;
    dd(xrange(1)-1:xrange(end)+1,yrange(1)-1,:)=0;
    dd(xrange(1)-1:xrange(end)+1,yrange(end)+1,:)=0;
    %imshow(dd,[0,255]);
    mov(nd)=im2frame(uint8(round(dd)));
    %pause;
end
movie2avi(mov,'track12','colormap',gray(236),'fps',12);
%movie(mov,1,12);