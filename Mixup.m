x = 'flxerat';
y = 'boutjoy';
[a,b] = mixup(x,y);
disp(a);
disp(b);
function [a, b] = mixup(c, d) 
s=min(length(c),length(d));
a(1:2:s) = c(1:2:s);
a(2:2:s) = d(2:2:s);
b(1:2:s) = d(1:2:s);
b(2:2:s) = c(2:2:s);
end