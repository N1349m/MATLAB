function [rij,xforce,yforce] = intForce(xpos,ypos,L)
% Calculates the vanderwaals force exerted on each atom at the positions
% described in xpos and ypos

N=length(xpos);

xforce=zeros(1,N);
yforce=zeros(1,N);
rij=zeros(N);
yij=zeros(N);
xij=zeros(N);

%Tests which pairings of atoms fall within the 2.5 radius
for i=1:N
    for j=1:N
        x=xpos(i)-xpos(j);
        y=ypos(i)-ypos(j);
        
        %Checks if atom feels force from 1 box over
        if x>L/2
            x=x-L;
        end
        if x<-L/2
            x=x+L;
        end
        if y>L/2
            y=y-L;
        end
        if y<-L/2
            y=y+L;
        end
        
        yij(i,j)=y;
        xij(i,j)=x;
        r=sqrt(x^2+y^2);
        rij(i,j)=r;
        
        %Assigns logic to be true if the atoms are within 2.5 of each other
        if rij(i,j)<2.5 && i~=j
            xforce(i)=xforce(i)+(2*r^-13-r^-7)*x/r*24;
            yforce(i)=yforce(i)+(2*r^-13-r^-7)*y/r*24;
        end
    end
end
% 
% for i=1:N
%     for j=1:N
%         %Adds to forces if logic is true
%         if logic(i,j)==1
%             x=xij(i,j);
%             y=yij(i,j);
%             r=rij(i,j);
%             
%         end
%     end
% end
% end