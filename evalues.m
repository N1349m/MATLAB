function [S, D] = evalues(A,num_iter)
% function [S, D] = evalues(A,num iter)
%
% This function prints an estimate of the maximum
% and minimum eigenvalues for the square matrix A
% provided that A is symmetric; it also prints the
% true eigenvalues in the diagonal matrix D
% and corresponding eigenvectors in the matrix S
%
% The two input parameters are the matrix A and
% the number of iterations, num iter, to run
Asize = size(A);
if Asize(1) ~= Asize(2)
    fprintf(1,'\nError! The matrix is not square!\n');
    S = [ ];
    D = [ ];
else
    if ~(isequal(A,A'))
        fprintf(1,'\nWarning! The matrix is not symmetric!\n');
    end
    n = Asize(1);
    x = zeros(n,num_iter);
    l = zeros(num_iter,1);
    min_iter = 0;
    max_iter = 0;
    lmin = inf;
    lmax = -inf;
    for i = 1:num_iter
        y = 2*rand(n,1)-1;
        if y'*y ~= 0
            x(:,i) = y /(y'*y)^0.5;
            l(i) = x(:,i)'*A*x(:,i);
            if l(i) < lmin
                lmin = l(i);
                min_iter = i;
            end
            if l(i) > lmax
                lmax = l(i);
                max_iter = i;
            end
        end
    end
    fprintf(1,'\n Smallest eigenvalue (estimated): %f\n', lmin);
    fprintf(1,'\n Largest eigenvalue (estimated): %f\n', lmax);
    fprintf(1,'\n The true eigenvalues and eigenvectors are\n');
    [S, D] = eig(A);
end % Asize(1) ?= Asize(2)
% end function