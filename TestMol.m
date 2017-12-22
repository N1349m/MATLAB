function [imp] = TestMol(sub1,sub2,pos,r,xpos,ypos,zpos,molr)
% By Nikhil Menon
% Checks the positions in xpos,ypos,zpos and againt some fixed positions to
% see if they fall within a given distance

N=length(xpos);

% Sets coordinates for axial substituents
sub1x=sub1(1,:)';
sub1y=sub1(2,:)';
sub1z=sub1(3,:)';
r1=r(:,1);

% Sets coordinates for equatorial substituents
sub2x=sub2(1,:)';
sub2y=sub2(2,:)';
sub2z=sub2(3,:)';
r2=r(:,2);

% Sets coordinates for ring molecules
posx=pos(1,:)';
posy=pos(2,:)';
posz=pos(3,:)';
r3=ones(6,1)*70;

% Calculates which molecules interset with the axial substituents
xdist1=repmat(xpos,6,1)-repmat(sub1x,1,N);
ydist1=repmat(ypos,6,1)-repmat(sub1y,1,N);
zdist1=repmat(zpos,6,1)-repmat(sub1z,1,N);
dist1=xdist1.^2+ydist1.^2+zdist1.^2;
rdist1=repmat(r1,1,N)+ones(6,N)*molr;
test1=find(dist1<=rdist1.^2==1);

% Calculates which molecules interset with the equatorial substituents
xdist2=repmat(xpos,6,1)-repmat(sub2x,1,N);
ydist2=repmat(ypos,6,1)-repmat(sub2y,1,N);
zdist2=repmat(zpos,6,1)-repmat(sub2z,1,N);
dist2=xdist2.^2+ydist2.^2+zdist2.^2;
rdist2=repmat(r2,1,N)+ones(6,N)*molr;
test2=find(dist2<=rdist2.^2==1);

% Calculates which molecules interset with the ring molecules
xdist3=repmat(xpos,6,1)-repmat(posx,1,N);
ydist3=repmat(ypos,6,1)-repmat(posy,1,N);
zdist3=repmat(zpos,6,1)-repmat(posz,1,N);
dist3=xdist3.^2+ydist3.^2+zdist3.^2;
rdist3=repmat(r3,1,N)+ones(6,N)*molr;
test3=find(dist3<=rdist3.^2==1);

[r1,c1]=ind2sub([6 N],test1);
[r2,c2]=ind2sub([6 N],test2);
[r3,c3]=ind2sub([6 N],test3);

temp1=[c1'; r1'; ones(1,length(r1))];
temp2=[c2'; r2'; ones(1,length(r2))*2];
temp3=[c3'; r3'; ones(1,length(r3))*3];

imp=[temp1 temp2 temp3];
end