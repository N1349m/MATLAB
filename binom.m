function [bin]=binom(m,k)
bin=factorial(m)/(factorial(k)*factorial(m-k));
end