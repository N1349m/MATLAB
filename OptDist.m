function [xpos,ypos] = OptDist(rad,l,n)
% Calculates optimum separation distance for n discs of radius rad in an l
% by l square

xpos=horzcat([rad rad l-rad l-rad],(l-2*rad)*rand(1,n-4)+rad);
ypos=horzcat([rad l-rad rad l-rad],(l-2*rad)*rand(1,n-4)+rad);

dtotal=0;
ndtotal=0;

cla;
axis([0 l 0 l]);

for a=5:n
    for b=1:4
            dtotal=dtotal+sqrt((xpos(a)-xpos(b))^2+(ypos(a)-ypos(b))^2);
    end
end

for a=1:n
    pos=[xpos(a)-rad ypos(a)-rad 2*rad 2*rad];
    rectangle('Position',pos,'Curvature',[1 1]);
end
xtemp=xpos;
ytemp=ypos;


for t=1:1000
    for i=5:n
        for d=1:8
            test=0;
            ndtotal=0;
            xpos(i)=xpos(i)+0.02*cos((d-1)*pi/4);
            ypos(i)=ypos(i)+0.02*sin((d-1)*pi/4);
            
            for a=5:n
                for b=1:4
                        ndtotal=ndtotal+sqrt((xpos(a)-xpos(b))^2+(ypos(a)-ypos(b))^2);
                end
            end
            
            for a=1:n
                for b=1:n
                    if (xpos(a)-xpos(b))^2+(ypos(a)-ypos(b))^2<4*rad^2 && a~=b
                        test=1;
                    end
                end
            end
            
            if xpos(i)<rad || ypos(i)<rad || xpos(i)>l-rad || ypos(i)>l-rad || test==1
                xpos(i)=xpos(i)-0.02*cos((d-1)*pi/4);
                ypos(i)=ypos(i)-0.02*sin((d-1)*pi/4);
            elseif ndtotal>=dtotal
                xpos(i)=xpos(i)-0.02*cos((d-1)*pi/4);
                ypos(i)=ypos(i)-0.02*sin((d-1)*pi/4);
            else
                cla;
                axis([0 l 0 l]);
                for i=1:n
                    pos=[xpos(i)-rad ypos(i)-rad 2*rad 2*rad];
                    rectangle('Position',pos,'Curvature',[1 1]);
                end
                drawnow
                dtotal=ndtotal;
                xtemp=xpos;
                ytemp=ypos;
            end
        end
    end
    if xpos~=xtemp | ypos~=ytemp
        break
    end
end
end