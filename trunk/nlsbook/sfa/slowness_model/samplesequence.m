function data=samplesequence(nframe)
    
    nwidth=16;
    load xypos100_199;
    x=xx;
    y=yy;
    fids=ff;
    nseq=size(x,2);
    seqcnt=1;
    for nfile=1:size(x,1)
        file=['data/actioncliptest00' num2str(fids(nfile)) '.avi'];
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
        xrange=round(x(nfile,ns)-nwidth/2+1:x(nfile,ns)+nwidth/2);
        yrange=round(y(nfile,ns)-nwidth/2+1:y(nfile,ns)+nwidth/2);
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
    save patches100_199 data;
end