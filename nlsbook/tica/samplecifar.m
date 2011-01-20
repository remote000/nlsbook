function X=samplecifar(class)
cnt=1;
X=[];
for i=1:5
    load(['data\cifar-10-batches-mat\data_batch_' num2str(i) '.mat']);
    fprintf('processing data batch %d\n',i);
    for j=1:size(data,1)
        if labels(j)==class
            dj=double(data(j,:))';
            X(:,cnt)=0.2989*dj(1:1024)+0.5870*dj(1025:2048)+0.1140*dj(2049:3072);
            cnt=cnt+1;
        end
    end        
end
save ['class' num2str(class)] X;
end
