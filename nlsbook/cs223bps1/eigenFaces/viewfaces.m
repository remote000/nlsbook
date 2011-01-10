for i=1:size(A,2)
    image(reshape(A(:,i),243,320));
    pause;
end