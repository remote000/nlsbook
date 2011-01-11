function [pixa,mine] = findSeam_Dyn(energy)
%FINDSEAM_DYN: Part B(ii)
%INPUT:
%   energy: the 2D matrix of image energy that you calculated in part (a)
%OUTPUT: 
%   pix is a 1-D array of the column indices in the seam to be removed
nr=size(energy,1);
nc=size(energy,2);
pix=zeros(size(energy));
minp=zeros(size(energy));
minp(1,:)=energy(1,:);
for i=2:nr
    [minp(i,1),pix(i,1)]=min(energy(i,1)+minp(i-1,1:2));
    for j=2:nc-1
        [minp(i,j),pix(i,j)]=min(energy(i,j)+minp(i-1,j-1:j+1));
        pix(i,j)=pix(i,j)+j-2;
    end
    [minp(i,nc),pix(i,nc)]=min(energy(i,nc)+minp(i-1,nc-1:nc));
    pix(i,nc)=pix(i,nc)+nc-2;
end
pixa=zeros(nr,1);
[mine,pixa(nr)]=min(minp(nr,:));
for i=nr-1:-1:1
    pixa(i)=pix(i+1,pixa(i+1));
end