function crossbow

y0 = input('Enter the initial position: ');
v0 = input('Enter the initial velocity: ');
t0 = input('Enter the initial time: ');
tfinal = input('Enter the end time: ');
N = input('Enter the number of intervals: ');

h = (tfinal - t0)/N;
t = zeros(N+1,1);
v = zeros(N+1,1);
y = zeros(N+1,1);
fv = zeros(N+1,1);
t(1) = t0;
v(1) = v0;
y(1) = y0;
for i = 1:N
    k1 = evalf(t(i),v(i));
    k2 = evalf(t(i)+0.5*h,v(i)+0.5*h*k1);
    k3 = evalf(t(i)+0.5*h,v(i)+0.5*h*k2);
    k4 = evalf(t(i)+h,v(i)+h*k3);
    fv(i) = k1;
    v(i+1) = v(i) + h/6*(k1 + 2*k2 + 2*k3 + k4);
    t(i+1) = t(i) + h;
    y(i+1) = y(i) + v(i)*h + 0.5*fv(i)*h^2;
end
fv(N+1) = evalf(t(N+1),v(N+1));
theoutput = [t v fv y];
plot(t,y)
xlabel('time')
ylabel('velocity')
title('Crossbow Problem')
pause
plot(t,y)
xlabel('time')
ylabel('position')
title('Crossbow Problem')
% end function crossbow

function f = evalf(t,v)
f = -0.04*v - 32;
% end function evalf