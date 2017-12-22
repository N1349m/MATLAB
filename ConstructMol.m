function [posx,posy,posz]= ConstructMol(x,y,z,r,prec)
% By Nikhil Menon
% Creates data to plot a series of spheres whose positions are given by x,
% y, and z with radii given by r
N=length(x);
posx=[];
posy=[];
posz=[];
for i=1:N
    posx=[posx;zeros(prec)];
    posy=[posy;zeros(prec)];
    posz=[posz;zeros(prec)];
end

for i=1:N
    ti=prec*i;
    [posx((ti-(prec-1)):ti,:),posy((ti-(prec-1)):ti,:),posz((ti-(prec-1)):ti,:)]=sphere((prec-1));
    posx((ti-(prec-1)):ti,:)=r(i)*posx((ti-(prec-1)):ti,:)+x(i);
    posy((ti-(prec-1)):ti,:)=r(i)*posy((ti-(prec-1)):ti,:)+y(i);
    posz((ti-(prec-1)):ti,:)=r(i)*posz((ti-(prec-1)):ti,:)+z(i);
end