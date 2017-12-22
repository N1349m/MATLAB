function G = FreeEnergy(x, HA, SA, HB, SB, w, T)
% FreeEnergy computes the free energy at the
% composition or compositions provided in x
GA=HA-T*SA;   %The free energy for A
GB=HB-T*SB;   %The free energy for A
G=GA.*x+GB.*(1-x)-w.*x.*(1-x);
end