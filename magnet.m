function [T,m] = magnet(size, T, B, J, iter, spins, quench)
%magnet simulates the Ising magnetic system using a Monte Carlo scheme.
%magnet requires 5 arguments:
%   size:   The size of the matrix representing the magnet
%   T:      The temperature
%   B:      The applied magnetic field
%   J:      The coupling between neighboring spins
%   iter:   The number of iterations over which to average
%   there are 2 additional optional arguments:
%   spins:  The initial spin configuration
%   quench: Quenched disorder applied to the system

%If we have no quenched disorder then set this to zero
if nargin < 7
    quench = zeros(size);
end

%If we have no set initial condition, start the spins to be random
if nargin < 6
    spins = 2*floor(2*rand(size))-1;
end

k = 1.38065*10^-23;

%Open a figure to show the spins
figure('Position', [1000, 50, 450, 900])
subplot(2,1,1)
p1=pcolor(spins);
caxis([-1,1]);
shading flat

%Open a second figure to show the plot of magnetization versus iteration.
subplot(2,1,2)
M=zeros(1,iter);
p2=plot(1:iter,M);
axis([1 iter -1 1]);
title('Magnetization');
xlabel('iteration');
ylabel('Magnetization');

%Compute the initial energy of the system
energy = compen(spins, B, J, quench);

%Now loop through all the iterations
for t=1:iter
    %at each iteration randomly choose a number of locations to flip
    %equal to the number of spins in the system
    loc = floor(1+rand(2, numel(spins))*size);
    
    %iterate over all these locations
    for pos = loc
        %at each location calculate the change in energy
        %starting with the contribution from the magnetic fields
        delta = 2*(B+quench(pos(1),pos(2))).*spins(pos(1),pos(2));
        %then including the interactions with all neighboring spins
        for s = [1 -1 0 0; 0 0 1 -1]
            delta = delta + 2*J*spins(pos(1),pos(2))*...
                spins(mod(pos(1)+s(1)-1,size)+1, mod(pos(2)+s(2)-1,size)+1);
        end
        if delta < 0 ||  rand()<exp(-delta/T)
            %accept the flip and update the energy
            spins(pos(1),pos(2)) = -spins(pos(1),pos(2));
            energy = energy + delta;
        end
    end
    
    %Calculate the new magnetization per spin
    M(t) = sum(sum(spins))/numel(spins);
    %Plot this data on the graph and update the spin map
    set(p1,'CData',spins);
    set(p2,'YData',M);
    drawnow
end
subplot(2,1,2)
%When done change the title of the graph so that it shows the average
%magnetization.
m = mean(M(floor(iter/2):iter));
title(['Average Magnetization: ' num2str(m)])
end

function energy=compen(spins, B, J, quench)
%The subfunction compen computes the energy of the system.  The first
%argument gives the spin configuration.  The second gives the magnetic
%filed.  The third the spin coupling, and the fourth the quenched field.
if nargin < 4
    quench = zeros(size(spins));
end

energy = -sum(sum(B*spins+quench.*spins));
for s = [1 0; 0 1]
    energy = energy - sum(sum(J*spins.*circshift(spins, s')));
end
end