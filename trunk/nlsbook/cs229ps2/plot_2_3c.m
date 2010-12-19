testset=[50,100,200,400,800,1400];
errs=zeros(1,6);
for r=1:6
    postfix=sprintf('.%d',testset(r));
    [spmatrix, tokenlist, trainCategory] = readMatrix(strcat('MATRIX.TRAIN',postfix));
    trainMatrix = full(spmatrix);
    numTrainDocs = size(trainMatrix, 1);
    numTokens = size(trainMatrix, 2);
    m1=trainMatrix(trainCategory==1,:);
    m0=trainMatrix(trainCategory==0,:);
    phi1=sum(m1,1);
    phi0=sum(m0,1);
    lensum1=sum(phi1);
    lensum0=sum(phi0);
    log_phi1=log((phi1+1)./(lensum1+numTokens));
    log_phi0=log((phi0+1)./(lensum0+numTokens));
    phiy=sum(trainCategory)/numTrainDocs;
    [spmatrix, tokenlist, category] = readMatrix('MATRIX.TEST');
    testMatrix = full(spmatrix);
    numTestDocs = size(testMatrix, 1);
    numTokens = size(testMatrix, 2);
    output = zeros(numTestDocs, 1);
    for i=1:numTestDocs
        prob1=testMatrix(i,:)*log_phi1'+log(phiy);
        prob0=testMatrix(i,:)*log_phi0'+log(1-phiy);
        output(i)=(prob1>prob0);
    end
    error=0;
    for i=1:numTestDocs
        if (category(i) ~= output(i))
            error=error+1;
        end
    end
    errs(r)=error/numTestDocs;
end
plot(testset,errs);
xlabel('training size');
ylabel('learning error');