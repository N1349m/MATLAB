theta = 0:.01:2*pi;
ki = 13;
Tcrss = 100;
radius = (ki / Tcrss * sin(theta./2) .* cos(theta./2) .* cos(3*theta./2)).^2/(2*pi);  
polar(theta, radius);