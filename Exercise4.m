function [a, b] = func1(c, d)
 a=c+d;
 b=c.*d;
end

function [a,b] = func2(c,d)
 a= [c d];
 b= [d c];
end

x=[1 2]
y=[4 3];
[y,x]=func1(x,y);
[x,y]=func2(y,x);
[y,x]=func1(y,x);
[x,y]=func2(x,y);
disp(x);
disp(y);