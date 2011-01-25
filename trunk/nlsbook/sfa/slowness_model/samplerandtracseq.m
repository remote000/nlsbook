function data=samplerandtracseq(nframe,nseq)
    
    halfwidth=8;
    seqcnt=1;
    for nfile=1:200
        file=['48row/actioncliptest00' sprintf('%03d',nfile) '.avi'];
        movinfo=aviinfo(file);
        if movinfo.NumFrames<nframe
            continue;
        end
        movclip=aviread(file,1:nframe);
    for ns=1:nseq
        %show the first frame and enter the tracking point.
        %seq=struct([]);
        fprintf('sample %s, sequence %d...\n',file,ns);
        dd=movclip(1).cdata;
        
         xstart=round(movinfo.Height/4);
        xradius=round(movinfo.Height/2);
        xcenter=xstart+randi(xradius);
        ystart=round(movinfo.Width/4);
        yradius=round(movinfo.Width/2);
        ycenter=ystart+randi(yradius);        
        xrange=xcenter-halfwidth+1:xcenter+halfwidth;
        yrange=ycenter-halfwidth+1:ycenter+halfwidth;
        seq(1)=im2frame(dd(xrange,yrange,:));
        dprev=dd(xrange,yrange,:);
        dprev=dprev(:);
        for nf=2:nframe
            dd=movclip(nf).cdata;
            normmin=1e6;
            ii=max(-5,1-xrange(1)):min(5,size(dd,1)-xrange(end));
            jj=max(-10,1-yrange(1)):min(10,size(dd,2)-yrange(end));
            for i=ii
                for j=jj
                    dnow=dd(xrange+i,yrange+j,:);
                    dnow=dnow(:);
                    normd=1-cormodel(double(dnow),double(dprev));
                    if normd<normmin
                        normmin=normd;
                        imin=i;jmin=j;
                    end
                end
            end
            xrange=xrange+imin;
            yrange=yrange+jmin;
            seq(nf)=im2frame(dd(xrange,yrange,:));
        end
        data{seqcnt}=seq;
        seqcnt=seqcnt+1;
    end
    end
    save 48row001_200track data;
end