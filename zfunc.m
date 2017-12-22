[x,y]=meshgrid(-10:0.5:10,-10:0.5:10);
z=real(sqrt(x+i*y));
meshc(x,y,z);