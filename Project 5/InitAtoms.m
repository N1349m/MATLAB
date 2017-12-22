function [xpos,ypos,xvel,yvel,m]= InitAtoms(N,KEn)
% Nikhil Menon
% Sets up N atoms with mass 1in a square matrix with random 
% velocities such that the average kinetic energy of all 
% molecules is KinEnergy

xpos=zeros(1,N);
ypos=zeros(1,N);
m=1;

% Assigns positions vectors
for i=1:ceil(sqrt(N))
    for j=1:ceil(sqrt(N))
        ypos(sqrt(N)*(i-1)+j)=j-0.5;
        xpos(sqrt(N)*(i-1)+j)=i-0.5;
    end
end

%Assigns velocity vectors
xvel=randn(1,N);
yvel=randn(1,N);

%Checks that the average kinetic energy is the same as input
if KEn==0
    fact=1;
else
    ke=m/2*(xvel.^2+yvel.^2);
    avgke=sum(ke)/N;
    fact=sqrt(KEn/avgke);
end

xvel=xvel*fact;
yvel=yvel*fact;
end