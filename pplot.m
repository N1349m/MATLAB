function [] = pplot (r1,r2,r3)
s=0:.15:100*pi;
slength=floor(100*pi/.15);
tspace=100.*r1.*pi/r2/slength;
t=0:tspace:100.*r1.*pi/r2;
x=(r1-r2).*cos(s)-r3.*cos(t);
y=(r1-r2).*sin(s)-r3.*sin(t);
plot(x,y)