function [F, G, Eel, Epn, Egr] = Fphidd(phi, Xi, mu, U, epsilon, N, h)

%Peierls energy
fphi=sin(pi*phi).^2;
gphi=pi*sin(2*pi*phi);

pind=[2:N,1];
nind=[N,1:N-1];

%elastic energy (use FFT)
phik = fft2(phi);
Eel = 0.5*mu*real(sum(sum( Xi.*phik'.*phik )))/N/N;

dEeldphik = Xi.*phik;
dEeldphi = real(ifft2(dEeldphik)) * mu;

dphidx = (phi(:,pind)-phi(:,nind))/(2*h);
dphidy = (phi(pind,:)-phi(nind,:))/(2*h);
d2phi = (phi(:,pind)+phi(:,nind)+phi(pind,:)+phi(nind,:)-4*phi)/(h^2);

Epn = sum(sum( fphi.*U ));
Egr = sum(sum( dphidx.^2 + dphidy.^2 )) * epsilon;

F = Eel + Epn + Egr;

G = dEeldphi + gphi .* U - 2* d2phi * epsilon;
