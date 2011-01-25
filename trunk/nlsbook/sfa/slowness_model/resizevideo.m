function resizevideo(fin, nr, fout)
    movinfo=aviinfo(fin);
    nf=min(500,movinfo.NumFrames);
    movclip=aviread(fin,1:nf);
    %imshow(movclip(1).cdata);
    %pause;
    d2=imresize(movclip(1).cdata,[nr,NaN]);
    %imshow(d2);
    sz=size(d2);
    
    for i=1:nf
        d2=imresize(movclip(i).cdata,[sz(1),sz(2)]);
        mov2(i)=im2frame(d2);
    end
    movie2avi(mov2,fout,'fps',movinfo.FramesPerSecond);
end