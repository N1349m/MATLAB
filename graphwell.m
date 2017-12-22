function[x,y1,y2,y3,y4,y5]=graphwell()
x=[1,2,3,4];
y1=[];
y2=[];
y3=[];
y4=[];
y5=[];
for i=1:length(x)
    Ef=finitewells(5, [0;x(i)]);
    if length(Ef)>=5
        y5=[y5,Ef(5)];
    else
        y5=[y5,0];
    end
    if length(Ef)>=4
        y4=[y4,Ef(4)];
    else
        y4=[y4,0];
    end
    if length(Ef)>=3
        y3=[y3,Ef(3)];
    else
        y3=[y3,0];
    end
    if length(Ef)>=2
        y2=[y2,Ef(2)];
    else
        y2=[y2,0];
    end
    if length(Ef)>=1
        y1=[y1,Ef(1)];
    else
        y1=[y1,0];
    end
end