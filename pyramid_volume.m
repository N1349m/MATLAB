function [volume] = pyramid_volume(L,h,n)
volume = 0;
cheight = h/n;
theight = h;
clength=L;
while n>0
    volume=(clength)^2*cheight+volume;
    clength=(theight-cheight)/theight*clength;
    theight = theight-cheight;
    n=n-1;
end
end