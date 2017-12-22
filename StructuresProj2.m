function [dhkl] = StructuresProj2
tic
planemat=[];
dhkl=zeros(1,32);
for h=0:5
    for k=0:5
        for l=0:5
            if h^2+k^2+l^2<=29 && h^2+k^2+l^2~=0 && k>=h && l>=k
                planemat=vertcat(planemat,[h k l]);
            end
        end
    end
end
Bragg=zeros(1,32);

for i=1:32
    dtemp=5.4626/sqrt(planemat(i,1)^2+planemat(i,2)^2+planemat(i,3)^2);
    dhkl(i)=dtemp;
    Bragg(i)=1/(2*dtemp);
end
bragground=round(Bragg*100);

myInfile = fopen('Atomic packing factors.txt', 'r');
formatSpec = '%f';
storageTemplate = [3, 39];
apf = fscanf(myInfile,formatSpec,storageTemplate);
fclose(myInfile);
apf=apf';

apfn=zeros(51,3);
for e=1:39
    place=round(apf(e,1)*100)+1;
    apfn(place,1)=apf(e,1);
    apfn(place,2)=apf(e,2);
    apfn(place,3)=apf(e,3);
end

for l=15:51
    if apfn(l,1)==0
        apfn(l,1)=(apfn(l-1,1)+apfn(l+1,1))/2;
        apfn(l,2)=(apfn(l-1,2)+apfn(l+1,2))/2;
        apfn(l,3)=(apfn(l-1,3)+apfn(l+1,3))/2;
    end
end

Cal=zeros(1,32);
Flu=zeros(1,32);
for t=1:32
    p=bragground(t);
    Flu(t)=apfn(p+1,2);
    Cal(t)=apfn(p+1,3);
end

Calpos=[0 0 0.5 0.5;0 0.5 0 0.5;0 0.5 0.5 0];
Flupos=[0.25 0.75 0.75 0.25 0.25 0.75 0.75 0.25; 0.25 0.25 0.75 0.75 0.25 0.25 0.75 0.75; 0.25 0.25 0.25 0.25 0.75 0.75 0.75 0.75];
% Flupos=[0.25; 0.25; 0.25];
Structfact=zeros(32,1);
for l=1:32
    calcos=0;
    calsin=0;
    flucos=0;
    flusin=0;
    for c=1:4
        q=Calpos(1,c)*planemat(l,1)+Calpos(2,c)*planemat(l,2)+Calpos(3,c)*planemat(l,3);
        calcos=calcos+Cal(l)*cos(2*pi*q);
        calsin=calsin+Cal(l)*sin(2*pi*q);
    end
    for f=1:8
        h=Flupos(1,f)*planemat(l,1)+Flupos(2,f)*planemat(l,2)+Flupos(3,f)*planemat(l,3);
        flusin=flusin+Flu(l)*sin(2*pi*h);
        flucos=flucos+Flu(l)*cos(2*pi*h);
    end
    Structfact(l)=Structfact(l)+(flucos+calcos)^2+(calsin+flusin)^2;
end
toc
intensity=zeros(0,32);
theta=asin(Bragg*1.5406);
j=[6,6,6,6,6,12,24,24,24,24,12,24,24,24,12,24,8,24,24,24,24,24,48,48,24,48,8,24,24,24,48,8];
for l=1:32
    %     j=1;
    %     for h=1:3
    %         if planemat(h)~=0
    %         j=j*2
    %         end
    %     end
    intensity(l)=Structfact(l)*j(l)*(1+(cos(2*theta(l)))^2)/(sin(theta(l))*sin(2*theta(l)));
end
theta=2*theta*180/pi;
scatter(theta,intensity)
end