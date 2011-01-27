function samplestillseq(nframe, nseq)
halfwidth=8;
    seqcnt=1;
    data=cell(3*nseq);
    for nfile=1:3
        file=['dv/120rcan' sprintf('%d',nfile) '.avi'];
        movinfo=aviinfo(file);
        if movinfo.NumFrames<nframe
            continue;
        end
        movobj=mmreader(file);
        seq(1:nframe)=struct('cdata', zeros(movinfo.Height, movinfo.Width, 3, 'uint8'),'colormap', []);
    for ns=1:nseq
        %show the first frame and enter the tracking point.
        %seq=struct([]);
        fprintf('sample %s, sequence %d...\n',file,ns);
        dd=read(movobj,1);
        xstart=round(movinfo.Height/4);
        xradius=round(movinfo.Height/2);
        xcenter=xstart+randi(xradius);
        ystart=round(movinfo.Width/4);
        yradius=round(movinfo.Width/2);
        ycenter=ystart+randi(yradius);
        xrange=xcenter-halfwidth+1:xcenter+halfwidth;
        yrange=ycenter-halfwidth+1:ycenter+halfwidth;
        seq(1:nframe)=im2frame(dd(xrange,yrange,:));
        data{seqcnt}=seq;
        seqcnt=seqcnt+1;
    end
   
    end
    data={data{1:seqcnt-1}};
    save can_120row_still data;
end