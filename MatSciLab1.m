xdif=5;
ydif=5;
pointmat=[];
xavg=0;
avg=0;

for i=1:30
    for j=1:30
        for k=1:33
            l1=data1(i,1);
            d1=data1(i,2);
            p1=data1(i,3);
            
            l2=data2(j,1);
            d2=data2(j,2);
            p2=data2(j,3);
            
            l3=data3(k,1);
            d3=data3(k,2);
            p3=data3(k,3);
            
            a=log(d1/d2); 
            b=log(l1/l2);
            c=log(p1/p2);
            
            d=log(d2/d3);
            e=log(l2/l3);
            f=log(p2/p3);
            
            x=(c*e-b*f)/(a*e-b*d); % d exponent
            y=(a*f-c*d)/(a*e-b*d); % l exponent
            xavg =xavg+x;
            yavg=yavg+x;
            if abs(x-4)<abs(xdif) && abs(y+2)<abs(ydif)
                x0=x;
                y0=y;
                pointmat=[l1 d1 p1 l2 d2 p2 l3 d3 p3];
            end
        end
    end
end

disp(x0);
disp(y0);
disp(pointmat);
disp(xavg);
disp(yavg);