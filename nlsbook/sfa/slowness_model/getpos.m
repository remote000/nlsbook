function getpos(fids,spf)
    nf=size(fids,1)*size(fids,2);
    x=zeros(nf,spf);
    y=zeros(nf,spf);
    for fi=1:nf
        file=['data/actioncliptest00' num2str(fids(fi)) '.avi'];
        movclip=aviread(file,1);
        nwidth=16;
        dd=movclip(1).cdata;
        imshow(dd);
        for i=1:spf
            [y(fi,i),x(fi,i)]=ginput(1);
            xrange=round(x(fi,i)-nwidth/2+1:x(fi,i)+nwidth/2);
            yrange=round(y(fi,i)-nwidth/2+1:y(fi,i)+nwidth/2);
            dd(xrange(1),yrange,:)=0;
            dd(xrange(end),yrange,:)=0;
            dd(xrange,yrange(1),:)=0;
            dd(xrange,yrange(end),:)=0;
            imshow(dd);
        end
        ff=fids(1:fi);
        xx=x(1:fi,:);
        yy=y(1:fi,:);
        save xypos ff xx yy;
        fprintf('finished extracting %s',file);
    end
    
end