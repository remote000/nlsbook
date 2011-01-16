function mov=myimg2avi(D)
nframe=size(D,1);
wsize=round(sqrt(size(D,2)));
y=showfeature(D,16,0);
ymax=max(max(y));
ymin=min(min(y));
y= (y-ymin)/(ymax-ymin)*255;
for i=1:nframe
    d=uint8(round(D(i,:)*255));
    d=reshape(d,wsize,wsize);
    for j=1:3
        s=ones(wsize,wsize)*y(i,j);
        s=uint8(round(s));
        d=[d,s];
    end
    for k=1:3
        rs=[];
        for j=1:4
        s=ones(wsize,wsize)*y(i,k*4+j);
        s=uint8(round(s));
        rs=[rs,s];
        end
        d=[d;rs];
    end
    
    
    mov(i)=im2frame(d,colormap(gray(256)));
end
%movie2avi(mov,'first16.avi','fps',5);
%mov=struct('cdata',cdata,'colormap',{gray(256)});
movie(mov,1,2);