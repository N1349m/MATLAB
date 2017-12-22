function [dhkl] = StructuresProj2
planemat=[];
dhkl=[];
for h=0:5
    for k=0:5
        for l=0:5
            if h^2+k^2+l^2<=29 && h^2+k^2+l^2~=0 && k>=h && l>=k
                planemat=vertcat(planemat,[h k l]);
            end
        end
    end
end
Bragg=[];
s=size(planemat);
for i=1:s(1)
    dtemp=5.4626/sqrt(planemat(i,1)^2+planemat(i,2)^2+planemat(i,3)^2);
    dhkl=[dhkl;dtemp];
    Bragg=[Bragg;1/(2*dtemp)];
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

Cal=[];
Flu=[];
for t=1:32
    p=bragground(t);
    Flu=[Flu;apfn(p+1,2)];
    Cal=[Cal;apfn(p+1,3)];
end

Calpos=[0 1 1 0 0.5 0.5 1 0.5 0 0 1 1 0 0.5;0 0 1 1 0 0.5 0.5 1 0.5 0 0 1 1 0.5; 0 0 0 0 0 0.5 0.5 0.5 0.5 1 1 1 1 1];
Flupos=[0.25 0.75 0.75 0.25 0.25 0.75 0.75 0.25; 0.25 0.25 0.75 0.75 0.25 0.25 0.75 0.75; 0.25 0.25 0.25 0.25 0.75 0.75 0.75 0.75];

Strucfact=zeros(32,1);
for l=1:32
    for c=1:14
        Strucfact(l)=Strucfact(l)+(Cal(l)*cos(2*pi*(Calpos(1,c)*planemat(l,1)+Calpos(2,c)*planemat(l,2)+Calpos(3,c)*planemat(l,3))))^2+(Cal(l)*sin(2*pi*(Calpos(1,c)*planemat(l,1)+Calpos(2,c)*planemat(l,2)+Calpos(3,c)*planemat(l,3))))^2;
    end
    for f=1:8
        Strucfact(l)=Strucfact(l)+(Flu(l)*cos(2*pi*(Flupos(1,f)*planemat(l,1)+Flupos(2,f)*planemat(l,2)+Flupos(3,f)*planemat(l,3))))^2+(Flu(l)*sin(2*pi*(Flupos(1,f)*planemat(l,1)+Flupos(2,f)*planemat(l,2)+Flupos(3,f)*planemat(l,3))))^2;
    end
end
intensity=Structfact*j;
end