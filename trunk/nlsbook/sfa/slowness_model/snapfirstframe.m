function snapfirstframe(fids)
    nf=size(fids,1)*size(fids,2);
    for fi=1:nf
        file=['dv/bin' sprintf('%d',fids(fi)) '.avi'];
        movclip=mmreader(file);
        dd=read(movclip,1);
        dd=rgb2gray(dd);
        imshow(dd);
        imwrite(dd,['dv/bin' sprintf('%d',fids(fi)) '.tif'],'tif');
        pause;
    end
end