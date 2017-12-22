function well(tmax, dt, L, dx, n1,n2)
% This function plots the wavefunction of a wavepacket initally centered at
% x=0 in a box with length L.
% tmax = maximum time to show
% dt = time increment
% L = Length of box
% dx = space increment
% n1,n2 = quantum number

x = 0:dx:L;                      % set up spatial grid
for t = 0:dt:tmax;                      % loop over time
    space1 = sqrt(2/L)*sin(n1*pi.*x/L);    % calcuate the wavefunction with n1
    time1 = exp(-1i*pi^2*n1^2*t/L^2);
    space2 = sqrt(2/L)*sin(n2*pi.*x/L);     % calcuate the wavefunction with n2
    time2 = exp(-1i*pi^2*n2^2*t/L^2);
    psi = space1*time1+space2*time2;
    
    plotwavefunction(x, dx, psi);       % use function below to plot
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plotwavefunction(x, dx, psi)
% This function plots the wave function two ways.  First as lines showing
% the real and imaginary parts, then as an envelope given by the magnitude
% of the complex value and a color giving the phase angle.

persistent ylim;                    % find the limits for the graphs
newylim = max(abs(psi));
if (isempty(ylim) | newylim > ylim) ylim=newylim; end
clf                                 % clear the figure

subplot(3,1,1);                     % choose the upper plot
plot(x, real(psi), x, imag(psi));
% plot the real and imaginary data as well as the expectation value
axis([x(1) x(end) -ylim ylim]);     % set the axis limits
legend('real \psi','imaginary \psi');   % add a legend

subplot(3,1,2);                     % choose the lower plot
axis([x(1) x(end) -ylim ylim]);     % set the axis limits
line([x(1) x(end)],[0 0],'Color','k');  % make a horizontal line
for n = 1:length(x)                 % loop over all x positions
    if(abs(psi(n))>0)               % draw a rectangle at each position
        rectangle('Position',[x(n) -abs(psi(n)) dx 2*abs(psi(n))],...
            'EdgeColor','none',...
            'FaceColor',hsv2rgb([0.5*angle(psi(n))/pi+0.5 1 1]));
    end
end

subplot(3,1,3);                     % choose the upper plot
plot(x, psi.*conj(psi),'k');
% plot the real and imaginary data as well as the expectation value
axis([x(1) x(end) 0 ylim^2]);     % set the axis limits
legend('Probability Density');   % add a legend

drawnow
end
