function E = ComputeEnergy(img)
%COMPUTE ENERGY - Part (a)
%OUTPUTS:
%   E: The energy function as defined by the equation in the problem
%   statement
%INPUTS:
%   img: The RGB representation of the loaded image
sobely=[1,2,1;0,0,0;-1,-2,-1];
sobelx=[1,0,-1;2,0,-2;1,0,-1];
E=zeros(size(img,1),size(img,2));
for i=1:3
    E=E+abs(filter2(sobely,img(:,:,i)))+abs(filter2(sobelx,img(:,:,i)));
end