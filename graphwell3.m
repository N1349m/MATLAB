function[x,y1,y2,y3,y4,y5,y6,y7,y8,y9]=graphwell3()
x=1:5;
y1=[];
y2=[];
y3=[];
y4=[];
y5=[];
y6=[];
y7=[];
y8=[];
y9=[];
concat=[1 0;2 3];
temp=[0;3];
for i=1:length(x)
    Ef=finitewells(1, temp);
    temp=[temp,concat];
    if length(Ef)>=9
        y9=[y9,Ef(9)];
    else
        y9=[y9,0];
    end
    if length(Ef)>=8
        y8=[y8,Ef(8)];
    else
        y8=[y8,0];
    end
    if length(Ef)>=7
        y7=[y7,Ef(7)];
    else
        y7=[y7,0];
    end
    if length(Ef)>=6
        y6=[y6,Ef(6)];
    else
        y6=[y6,0];
    end
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