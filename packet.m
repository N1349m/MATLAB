function packet(tmax, dt, xmax, dx, alpha, p0)
% This function plots the wavefunction of a wavepacket initally centered at
% x=0.  Right now it only can handle packets with no momentum (p0=0).  The
% input parameters are as follows:
% tmax = maximum time to show
% dt = time increment
% xmax = range of x will extend from -xmax to +xmax
% dx = space increment
% alpha = initial width of the wave packet
% p0 = momentum of wave packet (not currently used)
 
    x = -xmax:dx:xmax;                      % set up spatial grid
    for t = 0:dt:tmax;                      % loop over time
       % temp1 = 1+2.*i.*t./(alpha.^2);      % calcuate the wavefunction
       % temp2 = - x.^2./(2.*alpha.^2.*temp1);
       % psi = exp(temp2)./sqrt(sqrt(pi).*alpha.*temp1);
        temp1 = 1+i.*t./(0.5.*alpha.^2);
        temp2 = i*p0.*x-i*p0^2*t-(x-2*p0*t).^2./(2.*alpha.^2.*temp1);
        psi = exp(temp2)./sqrt(sqrt(pi).*alpha.*temp1);

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
