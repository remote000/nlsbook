function pieceupseq(data,ncol)
    nseq=size(data,2);
    nrow=floor(nseq/ncol);
    nframe=size(data{1},2);
    nwidth=size(data{1}(1).cdata,2);
    nheight=size(data{1}(1).cdata,1);
    for nf=1:nframe
        afrm=uint8(zeros(nheight*nrow,nwidth*ncol,3));
        for nr=1:nrow
            for nc=1:ncol
                nseq=(nr-1)*ncol+nc;
                afrm((nc-1)*nheight+1:nc*nheight,(nr-1)*nwidth+1:nr*nwidth,:)=data{nseq}(nf).cdata;
            end
        end
        mov(nf)=im2frame(afrm);
    end
    movie2avi(mov,'dv_50_55_notrack');
end