function [chance]=Pchance(k,m,p)
chance=binom(m,k)*p^k*(1-p)^(m-k);
disp(num2str(chance))
end