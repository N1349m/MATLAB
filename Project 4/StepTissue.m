function [NewU, NewV] = StepTissue(U, V, D, dt)
% This procedure will advance the clock on U and V by one time step

N=length(U);
NewU=zeros(N);
NewV=zeros(N);


for x=2:N-1
    for y=2:N-1
        % Simplifies 
        u=U(x,y);
        v=V(x,y);
        
        
        Uavg=(U(x-1,y)+U(x+1,y)+U(x,y-1)+U(x,y+1))/4;
        Uthreshold=(v+0.01)/0.3;
        
        % Calculates excite value using Uthreshold
        if u<=0.0001
            Uexcite=0;
            NewV(x,y)=(1-dt)*v;
        elseif u<=Uthreshold
            Uexcite=u/(1-10000*dt*(1-u)*(u-Uthreshold));
            NewV(x,y)=(1-dt)*v+dt*u;
        elseif u>Uthreshold
            Uexcite=u*(1+10000*dt*(u-Uthreshold))/(1+10000*dt*u*(u-Uthreshold));
            NewV(x,y)=(1-dt)*v+dt*u;
        end
        NewU(x,y)=Uexcite+dt*D*(Uavg-u);
    end
end
for i=1:N
    % Sets up edges of NEWU matrix
    NewU(1,i)=NewU(2,i);
    NewU(N,i)=NewU(N-1,i);
    NewU(i,1)=NewU(i,2);
    NewU(i,N)=NewU(i,N-1);
end

end