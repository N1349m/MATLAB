function Project3()
% By Nikhil Menon
%   Takes a txt file and converts it to matrix. Then, uses the matrix to
%   simulate the movement of molecules in 3 dimensions to find the 
%   diffusion constant.

% Collecting data from file
myInfile = fopen('pos.txt', 'r');
formatSpec = '%f';
storageTemplate = [82, Inf];
indata = fscanf(myInfile,formatSpec,storageTemplate);
fclose(myInfile);
indata = indata';


time=indata(1:end,1)';
xdata=[];
ydata=[];
zdata=[];
%   Separates data into x,y, and z groups
for i=2:3:82
    xdata=[xdata,indata(:,i)];
    ydata=[ydata,indata(:,i+1)];
    zdata=[zdata,indata(:,i+2)];
end
N=size(xdata);


% Evaluates the mean square for x
xi0=xdata(1,1:end);
xsquared=[];
for n=1:N(1)
    for m=1:N(2)
        xsquared(n,m)=(xdata(n,m)-xi0(1,m)).^2;
    end
end
xfinal=sum(xsquared,2)/27;
P = polyfit(time,xfinal',1);
Dx=P(1)/2;

% Evaluates the mean square for y
yi0=ydata(1,1:end);
ysquared=[];
for n=1:N(1)
    for m=1:N(2)
        ysquared(n,m)=(ydata(n,m)-yi0(1,m)).^2;
    end
end
yfinal=sum(ysquared,2)/27;
P = polyfit(time,yfinal',1);
Dy=P(1)/2;

% Evaluates the mean square for z
zi0=zdata(1,1:end);
zsquared=[];
for n=1:N(1)
    for m=1:N(2)
        zsquared(n,m)=(zdata(n,m)-zi0(1,m)).^2;
    end
end
zfinal=sum(zsquared,2)/27;
P = polyfit(time,zfinal',1);
Dz=P(1)/2;

%   Evaluates final diffusion constant
datafinal=(2*xfinal+2*yfinal+2*zfinal)/6;
scatter(time,datafinal,'b','.'); 
P = polyfit(time,datafinal',1);
datafit = P(1)*time+P(2);
hold on;
plot(time,datafit','r-.');
Dfinal2=P(1)/2; %calculated by graphical fit
Dfinal=(2*Dx+2*Dz+2*Dy)/6; %calculated using provided formula


fprintf('The x coefficient is %.3f\n',Dx);
fprintf('The y coefficient is %.3f\n',Dy);
fprintf('The z coefficient is %.3f\n',Dz);
fprintf('The final coefficient by graphing is %.3f\n',Dfinal2);
fprintf('The final coefficient by calculation is %.3f\n',Dfinal);
end