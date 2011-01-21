data=aviread('data/actioncliptest00001.avi');
dd=data(1).cdata;
len=size(data,2);
imshow(dd);
[y,x]=ginput(1);
xrange=x-8:x+8;
yrange=y-8:y+8;
dd(xrange(1)-1,yrange(1)-1:yrange(end)+1,:)=0;
dd(xrange(end)+1,yrange(1)-1:yrange(end)+1,:)=0;
dd(xrange(1)-1:xrange(end)+1,yrange(1)-1,:)=0;
dd(xrange(1)-1:xrange(end)+1,yrange(end)+1,:)=0;
imshow(dd);
mov(1)=im2frame(uint8(round(dd)));

dprev=dd(xrange,yrange,:);
dprev=dprev(:);
idx=zeros(len,1);
idy=zeros(len,1);
for nd=2:len
    dd=data(nd).cdata;
    %dd=double(d);
    normmin=1e6;
    for i=-5:5
        for j=-10:10
            dnow=dd(xrange+i,yrange+j,:);
            dnow=dnow(:);
            normd=1-cormodel(double(dnow),double(dprev));
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