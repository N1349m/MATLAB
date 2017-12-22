function[] = atomwrite(x,y,z)
A=[x;y;z];
MyFile=fopen('atomdata.txt','w');
fprintf(MyFile,'%.3f %.3f %.3f',A);
fclose(MyFile);
end