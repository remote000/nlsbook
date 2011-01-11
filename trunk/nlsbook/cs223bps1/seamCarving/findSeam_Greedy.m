function [pix,mine] = findSeam_Greedy(energy)
%FINDSEAM GREEDY: Part B(i)
%INPUT:
%   energy: the 2D matrix of image energy that you calculated in part (a)
%OUTPUT: 
%   pix is a 1-D array of the column indices in the seam to be removed
pix=zeros(size(energy,1),1);
minp=zeros(size(energy,1),1);
nc=size(energy,2);
[minp(1),pix(1)]=min(energy(1,:));
for i=2:size(energy,1)
    prev=pix(i-1);
    if prev==1
        [minp(i),pix(i)]=min(energy(i,1:2));
        continue;
    end
    if prev==nc
        [minp(i),pix(i)]=min(energy(i,nc-1:nc));
        pix(i)=nc-2+pix(i);
        continue;
    end
    [minp(i),pix(i)]=min(energy(i,prev-1:prev+1));
    pix(i)=prev-2+pix(i);
end
mine=sum(minp);
