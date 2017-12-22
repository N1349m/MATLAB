r1=0.2;
r2=5;
mol1=6;
total=10;
f1=60/100;
f2=1-f1;
molcon=0;
output=[];
for i=1:10
    Fa=(r1*f1^2+f1*f2)/(r1*f1^2+2*f1*f2+r2*f2^2);
    mol1=mol1-Fa;
    molcon=molcon+Fa;
    cumcon=molcon/i;
    total=total-1;
    output=[output;f1 Fa cumcon];
    f1=mol1/total;
    f2=1-f1;
end
c=10:10:100;
plot(c,output(:,1),c,output(:,2),c,output(:,3))
disp(output);