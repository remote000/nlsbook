for nfile=1:200
    file=['data/actioncliptest00' sprintf('%03d',nfile) '.avi'];
    fprintf('converting %s....\n',file);
    fileout=['48row/actioncliptest00' sprintf('%03d',nfile) '.avi'];
    resizevideo(file,48,fileout);
end