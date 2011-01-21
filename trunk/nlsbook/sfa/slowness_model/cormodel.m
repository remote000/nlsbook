function cor=cormodel(x,y)
    ux=mean(x);
    uy=mean(y);
    vx=sqrt(mean((x-ux).^2));
    vy=sqrt(mean((y-uy).^2));
    cor=mean((x-ux).*(y-uy));
    if(vx*vy==0)
        cor=-1;
    else
        cor=cor/vx/vy;
    end
end