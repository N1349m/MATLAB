function [sucreac] = SimtestMol (N,sub1,sub2,pos,r,molr)
% By Nikhil Menon
% Tests which fixed molecule defined by position and radii data a set of N
% molecules with random positions and velocities will intersect

% Initializes positions and velocities
xvel = rand(1,N)-0.5;
yvel = rand(1,N)-0.5;
zvel = rand(1,N)-0.5;
xpos = (600+molr/2)*rand(1,N)-200;
ypos = (700+molr/2)*rand(1,N)-300;
zpos = (450+molr/2)*rand(1,N)-300;

l=11;
% Number of successful reactions
sucreac=0;

% If molecules initialize within a fixed molecule, sets the positions to 0
while l>1
    [imp] = TestMol(sub1,sub2,pos,r,xpos,ypos,zpos,molr);
    l=length(imp);
    if l~=0
        xpos(imp(1,:))=(600+molr/2)*rand-200;
        ypos(imp(1,:))=(700+molr/2)*rand-300;
        zpos(imp(1,:))=(450+molr/2)*rand-200;
        xvel = rand(1,N)-0.5;
        yvel = rand(1,N)-0.5;
        zvel = rand(1,N)-0.5;
    end
end

for t=1:2000
    [imp] = TestMol(sub1,sub2,pos,r,xpos,ypos,zpos,molr);
    xvel(imp(1,:)) = 0;
    yvel(imp(1,:)) = 0;
    zvel(imp(1,:)) = 0;
    xpos=xpos+xvel*2;
    ypos=ypos+yvel*2;
    zpos=zpos+zvel*2;
end

% Totals up the number of moecular interactions
total = zeros(6,2);
for l=1:length(imp)
    x=imp(2,l);
    y=imp(3,l);
    if y ~=3
        total(x,y)=total(x,y)+1;
    end
end

for i1=1:6
    if sub1(4,i1) == 1 && total(i1,1)
        sucreac=sucreac+total(i1,1);
    end
    if sub2(4,i1) == 1 && total(i1,2)
        sucreac=sucreac+total(i1,2);
    end
end
end