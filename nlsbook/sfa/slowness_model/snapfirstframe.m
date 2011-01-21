function snapfirstframe(fids)
    nf=size(fids,1)*size(fids,2);
    for fi=1:nf
        file=['data/actioncliptest000' num2str(fids(fi)) '.avi'];
        movclip=aviread(file,1);
        dd=movclip(1).cdata;
        dd=rgb2gray(dd);
        imshow(dd);
        imwrite(dd,['data/actioncliptest000' num2str(fids(fi)) '.tif'],'tif');
        pause;
    end
end