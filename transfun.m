function transfun(A)
m = size(A,1);
n = size(A,2);
if n~=m
fprintf(1,'\nError! The matrix is not square!\n');
else
if A == A'
fprintf(1,'\nThe matrix is symmetric!\n');
else
fprintf(1,'\nThe matrix is not symmetric!\n');
end
if A == -A'
fprintf(1,'\nThe matrix is skew-symmetric!\n');
else
fprintf(1,'\nThe matrix is not skew-symmetric!\n');
end
if inv(A) == A'
fprintf(1,'\nThe matrix is orthogonal\n');
else
fprintf(1,'\nThe matrix is not orthogonal!\n');
end
end