function Project2b(V0,Q,maxtime,minT)

function dy= HIVodefun(t,y)
dy=zeros(3,1);
    dy(1)=-0.001*y(1)*y(3);
    dy(2)=0.001.*y(1).*y(3)-0.005.*y(2);
    dy(3)=10*(1-Q)*y(2)-(0.05*y(3)*y(1));
end
[t,y]=ode45(@HIVodefun,[0:maxtime],[1,0,V0]);
i=1;
T=[];
I=[];
V=[];
t=[];
while i<maxtime && y(i,1)+y(i,2)>minT
    T=[T,y(i,1)];
    I=[I,y(i,2)];
    V=[V,y(i,3)];
    t=[t,i-1];
end
subplot(2,1,1);
plot(t,T,'b',t,I,'g');
axis normal;
xlabel('T-cell Count');
ylabel('Time');
legend('Uninfected','Infected');
subplot(2,1,2);
plot(t,V);
xlabel('Viral Load');
ylabel('Time');
axis normal;
end
