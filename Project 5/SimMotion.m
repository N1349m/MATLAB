function [tE,tKE,tPE,allxpos,allypos]= SimMotion(N,KEn,T,dt)
%Simulates the motion of atoms when
% given number of atoms and average kinetic energy

%Initializes positions and velocities
[xpos,ypos,xvel,yvel,m]= InitAtoms(N,KEn);

%Length of box
L=8;

tripx=[xvel;xvel];
tripy=[yvel;yvel];

tE=[];
tKE=[];
tPE=[];
allxpos=xpos;
allypos=ypos;

figure('Position', [700 50 500 900]);
atoms=subplot(2,1,1);
axis(atoms,[0,L,0,L]);
energy=subplot(2,1,2);
axis(energy,[0 T -inf inf]);

for i=1:N
    subplot(atoms)
    rectangle('Curvature', [1 1],'Position',[xpos(i),ypos(i),.1,.1]);
    drawnow;
end

for t=1:T
    
    %Calculates new positions
    xpos=xpos+xvel*dt;
    ypos=ypos+yvel*dt;
    
    %Checks that new positions are within box
    [xpos,ypos]=CheckBounds(xpos,ypos,L);
    
    %Draws atoms on a figure
    subplot(atoms);
    cla(atoms);
    
    for i=1:N
        rectangle('Curvature', [1 1],'Position',[xpos(i),ypos(i),.1,.1]);
    end
    
    %Calculates force
    [rij,xforce,yforce] = intForce(xpos,ypos,L);
    
    %Calculates new velocity
    xvel=xvel+ xforce/m*dt;
    yvel=yvel+ yforce/m*dt;
    
    tripx(1,:)=tripx(2,:);
    tripx(2,:)=xvel;
    tripy(1,:)=tripy(2,:);
    tripy(2,:)=yvel;
    
    %Checks energy conservation
    [ke,pe,e,xvel,yvel] = ConserveE(tripx,tripy,m,rij,KEn);
    tE=[tE,e];
    tKE=[tKE,ke];
    tPE=[tPE,pe];
    time=1:t;
    
    % Plots energies
    subplot(energy);
    plot(energy,time,tE,time,tKE,time,tPE);
    drawnow
    
    allxpos=[allxpos;xpos];
    allypos=[allypos;ypos];
end
end