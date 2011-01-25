function samplerandseq(nframe,nseq)
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
        for nf=1:nframe
            dd=movclip(nf).cdata;
            
            seq(nf)=im2frame(dd(xrange,yrange,:));
        end
        data{seqcnt}=seq;
        seqcnt=seqcnt+1;
    end
    end
    save patches001_200 data;
end