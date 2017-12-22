T=1:933;
invT=1./T;
c=-0.75/(8.62*10^-5);
plot(invT,c*invT)
xlabel('1/T')
ylabel('ln(mole fraction)')