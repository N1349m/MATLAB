function [df] = hivodefun(t,matrix)
df=zeros(4,1);
df(1)=-0.001*matrix(1)*matrix(3);
df(2)=0.001*matrix(1)*matrix(3)-0.005*matrix(2);
df(3)=10*(1-matrix(4))*matrix(2)-0.05*matrix(3)*matrix(1);
df(4)=0;
end