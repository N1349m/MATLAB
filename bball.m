function []= bball(v0,y0,tmin,tmax)
t=tmin;
y=y0;
v=v0;
upperbound=floor((tmax-tmin)/0.01);
for index=1:upperbound
    vnext=v(index)-0.098;
    ynext=y(index)+vnext*0.01;
    if ynext>=0
        y(index+1)=ynext;
        v(index+1)=vnext;
        t(index+1)=t(index)+0.01;
    else
        break;
    end
end
y(upperbound+1)=0;
t(upperbound+1)=t(upperbound)+0.01;
plot(t,y);
end