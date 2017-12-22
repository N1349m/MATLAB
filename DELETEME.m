B=0:0.25:1.5;
mfinal = [];
for  i=1:length(B)
    [temp,m]=magnet(20,2,B(i),0,500);
    mfinal=[mfinal,m];
end
disp(mfinal)