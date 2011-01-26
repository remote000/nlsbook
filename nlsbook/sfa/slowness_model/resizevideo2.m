function resizevideo2(fin, nr, fout)
    movclip=mmreader(fin);
    %imshow(movclip(1).cdata);
    %pause;
    d2=read(movclip,1);
    d2=imresize(d2,[nr,NaN]);
    %imshow(d2);
    sz=size(d2);
    nf=min(500,movclip.NumberOfFrames);
    for i=1:nf
        d2=read(movclip,i);
        d2=imresize(d2,[sz(1),sz(2)]);
        mov2(i)=im2frame(d2);
    end
    movie2avi(mov2,fout,'fps',movclip.FrameRate);
end