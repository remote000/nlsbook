%%%%%%%plotb.m%%%%%%%%%%
addpath('../liblinear-1.7/windows');
load PS0_SVM_partb;
data=data_partb;
label=label_partb;
C=logspace(-4,4,5);
%C=1;
for para=1:size(C,2)
    str=['-B 1 -c ' num2str(C(para))];
    %str=['-B 1'];
    model=train(label,sparse(data),str);
    theta=model.w;
    x1max=max(data(:,1));
    x1min=min(data(:,1));
    step=(x1max-x1min)/100.0;
    m=size(data,1);
    x1=x1min:step:x1max;
    x2=-theta(3)/theta(2)-theta(1)/theta(2).*x1;
    figure; 
    hold on;
    plot(x1,x2);
    for i=1:m
        if(label(i)==1)
            plot(data(i,1),data(i,2),'b+');
        else
            plot(data(i,1),data(i,2),'ro');
        end
    end
    xlabel('x1');
    ylabel('x2');
    title(['C=' num2str(C(para))]);
    pause;
end