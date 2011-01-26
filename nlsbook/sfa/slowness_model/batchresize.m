for nfile=1:3
    file=['dv/can' sprintf('%d',nfile) '.avi'];
    fprintf('converting %s....\n',file);
    fileout=['dv/120rcan' sprintf('%d',nfile) '.avi'];
    resizevideo2(file,120,fileout);
end