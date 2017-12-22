function [xpos,ypos]=CheckBounds(xpos,ypos,L)
for i=1:length(xpos)
    % Checks that x values are within bounds
    while (xpos(i)>L || xpos(i)<0 )
        if xpos(i)<0
            xpos(i)=xpos(i)+L;
        end
        
        if xpos(i)>L
            xpos(i)=xpos(i)-L;
        end    
    end
    
    % Checks that x values are within bounds
    while (ypos(i)>L || ypos(i)<0)
        if ypos(i)<0
            ypos(i)=ypos(i)+L;
        end
        if ypos(i)>L
            ypos(i)=ypos(i)-L;
        end
    end
end