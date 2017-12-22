function [ke,pe,e,xvel,yvel] = ConserveE(tripx,tripy,m,rij,KEn)
% Makes sure that energy i conserved in all steps and corrects
% velocities to ensure that average kinetic energy stays constant

N=length(tripx);

% Sets kinetic energy
ke1=m/2*(tripx(1,:).^2+tripy(1,:).^2);
ke2=m/2*(tripx(2,:).^2+tripy(2,:).^2);
ke=(ke1+ke2)/2;

% Sets potential energy
pe=zeros(1,N);
for i=1:N
    for j=1:N
        r=rij(i,j);
        if r<2.5 && i~=j
            pe(i)=pe(i)+4*((1/r)^12-(1/2.5)^12-(1/r)^6+(1/2.5)^6);
        end
    end
end

pe=sum(pe)/2;
ke=sum(ke);
e=ke+pe;

% Resets average kinetic energy per molecule
if KEn==0
    fact=1;
else
    avgke=sum(ke)/N;
    fact=sqrt(KEn/avgke);
end
xvel=tripx(2,1:N)*fact;
yvel=tripy(2,1:N)*fact;
end