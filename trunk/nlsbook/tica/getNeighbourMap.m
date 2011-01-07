function P=getNeighbourMap(n,r)
    P=zeros(n,n);
    gridsize=round(n^0.5);
    for xi=1:gridsize
        for yi=1:gridsize
            temp=zeros(gridsize,gridsize);
            yrange=(yi-r):(yi+r);
            xrange=(xi-r):(xi+r);
            yid=(yrange<1);
            yrange(yid)=yrange(yid)+gridsize;
            yid=(yrange>gridsize);
            yrange(yid)=yrange(yid)-gridsize;
            xid=(xrange<1);
            xrange(xid)=xrange(xid)+gridsize;
            xid=(xrange>gridsize);
            xrange(xid)=xrange(xid)-gridsize;
            temp(yrange,xrange)=1;
            P((xi-1)*gridsize+yi,:)=temp(:)';
        end
    end
    P=P./(sqrt(sum(P.^2,2))*ones(1,n));
end