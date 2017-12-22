function ShowHull(HA1, SA1, HB1, SB1, w1, HA2, SA2, HB2, SB2, w2, T)
% ShowHull plots the free energies for two phases
% as well as the convex hull for the two phases.
x=0:0.01:1;
G1=FreeEnergy(x,HA1,SA1,HB1,SB1,w1,T); %Free energy for 1st state
G2=FreeEnergy(x,HA2,SA2,HB2,SB2,w2,T); %Free energy for 2nd state
[CHull,Phases]=ConvexHull(x,G1,w1,G2,w2); %Calculates the convex hull with the 2 G functions
plot(x,G1,'r',x,G2,'b',x,CHull,'k--','LineWidth',2);
%Setting axis titles
xlabel('composition');
ylabel('free energy');
end