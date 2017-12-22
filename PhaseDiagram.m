function PhaseDiagram(HA1, SA1, HB1, SB1, w1, HA2, SA2, HB2, SB2, w2, Tmin, Tmax)
% PhaseDiagram plots a phase diagram by creating a
% pcolor plot where each box represents a given
% composition and temperature. Each box is colored
% depending on whether pure phase 1 (red), pure
% phase 2 (blue) or a mixture (green) is the most
% stable.
Tint=(Tmax-Tmin)/100; %intervals for the temperature
x=0:0.01:1;
T=Tmin:Tint:Tmax;
PhasesNew=[]; %The matrix of the new phase values, with the row corresponding to concentration and the column corresponding to temperature 
for k=1:1:101
    G1=FreeEnergy(x,HA1,SA1,HB1,SB1,w1,T(k)); %Free energy for 1st state
    G2=FreeEnergy(x,HA2,SA2,HB2,SB2,w2,T(k)); %Free energy for 2nd state
    [~,Phases]=ConvexHull(x,G1,w1,G2,w2);
    PhasesNew=[PhasesNew;Phases];
end
pcolor(x,T,PhasesNew);
shading flat;
custommap= [1,0,0;0,0,1;0,1,0];
colormap(custommap);
end