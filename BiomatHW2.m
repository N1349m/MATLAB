% t=1:28000;
% c= 3;
% k=.06;
% p=1-1./(c*k*t+1);
% x=1./(1-p);
% plot(t,x);
% xlabel('Time (s)');
% ylabel('Degree of polymerization');
% axis([0 28000 0 5000]);
% 
% for i=1:length(x)
%     if (x(i)>=300 && x(i)<301)
%         disp(t(i));
%     end
% end
% 
% mn=24116;
% manil=108.14;
% mtere=166.13;
% mbenzo=122.12;
% wanil=39.31;
% wtere=59.81;
% wbenzo=0.88;
% 
% molanil=wanil/manil;
% moltere=wtere/mtere;
% molbenzo=wbenzo/mbenzo;
% r=2*moltere/(2*molanil+2*molbenzo);
% 
% m0=119.6;
% xn=mn/m0;
% p=(1+r-(1+r)/xn)/(2*r);
% r=2*moltere/(molanil*2+2*2*molbenzo);
% xnnew=(1+r)/(1+r-2*p*r);

kd=4.47e-6;
kp2kt=1e-1;
f=0.4;
m=0.9988;
i=0.00413;

%t=-log(0.5)/(kp2kt*(f*kd)^0.5*i^0.5)

t=24.7*3600;
i=i*exp(-2*f*kd*t);

xn=kp2kt*m/(2*(f*kd*i)^0.5)
