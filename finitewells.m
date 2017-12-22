function [Efinal]=finitewells(Vext, struct)
%This code solves for the solutions of the Schrodinger equation in a series
%of quantum wells.  The assumption is that the lowest energy well is set to
%a potential of 0.  Vext is the potential outside the set of wells and out
%to +/- infinity.  The input struct is a 2xN matrix where N is the number
%of steps in the structure.  The first row contains the potential at the
%step and the second row gives the width of the step.  So to simulate a
%single well of depth 2 and width 3 you would execute: finitewells(2,[0;3])
%To simulate two wells of this kind separated by a barrier of width 1 you
%could execute: finitewells(2, [0 2 0; 3 1 3])

%Basic outline of code:
%  This code works by first scanning over the energies from the bottom of
%  the lowest well to the external potential.  It then locates where there
%  are zero crossings of the prefactor of the exp(+kx) term in the outgoing
%  wave function since this term would correspond to solutions that do not
%  blow up at +inifinity.  Thus only wavefunctions that meet that criterion
%  constitute valid solutions. 
%  Once a zero crossing is found we zero in on the exact location of the
%  zero crossing by using Newton's method of successive linear
%  approximation.  This is done for each zero crossing.
%  The resulting zero crossings correspond to solutions each with a
%  different energy.  These are then used to recompute the wavefunction
%  including the prefactors of the exp(ikx) and exp(-ikx) (or exp(-kx) and
%  exp(+kx)) terms for each region of the well structure.  These are
%  plotted along with the probability density of the wavefunction.

    dE = Vext/10000;                    %set the size of the energy steps
    energies = dE:dE:Vext-dE;           %consists of all E values tested
    Efinal=[];
    m=1;
    for E = energies  %for each of these energies calcuate the prefactors 
                      %of the two components of the resultant wavefunction
        [A(m),B(m)]=transfermat(Vext, E, struct);
    m=m+1;
    end

    cross = sign(B(1:end-1))~=sign(B(2:end)); %find the zero crossings
    nums= 1:length(B);
    p=1;
    for c = nums(cross)            %count over all the crossings
        B1=B(c);
        E1=energies(c);
        B2=B(c+1);
        E2=energies(c+1);
        for q=1:20                  %perform 20 steps of Newton's scheme to 
                                    %converge on the zero crossing
            E = (B1*E2-B2*E1)/(B1-B2);
            [Ac,Bc]=transfermat(Vext,E,struct);
            if sign(Bc)==sign(B1) 
                B1=Bc;
                E1=E;
            else
                B2=Bc;
                E2=E;
            end
        end
        E
        Efinal=[Efinal,E];%once we have the zero crossing get the wavefunction
        [Ac,Bc,P]=transfermat(Vext,E,struct);
                      %and plot it to a new figure window
        figure(p);
        clf;
        plotbarriers(E,Vext,struct,P);
        p=p+1;
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The transfermat function calculates the wavefunction by using the
% solution to the Schroinger equation for a constant potential.  We use the
% fact that if we know there is a constant potential V between 0 and L then
% if we know Psi and Psi' at 0 we can calculate the prefactors A and B of
% the wavefunction Psi = A exp(ikx)+B exp(-ikx).  Then that allows us to
% find the values of Psi and Psi' at L.  This can then be fed into the next
% constant potential in line.  This can all be reduced to a matrix equation
% such that 
% [Psi0; Psi0'] = [cos(kL), sin(kL)/k; -k sin(kL), cos(kL)]*[PsiL; PsiL']
% This matrix is known as the transfer matrix.
function [A, B, P] = transfermat(Vext, E, struct)
    
    M = eye(2);
    k= sqrt(2*(E-Vext));
    T = 0.5*[1 -i/k; 1 +i/k];
    
    init = [1;-i*k];
    if (nargout==3) 
        P = zeros(2,size(struct,2)+1); 
        P(:,1)= init;
    end

    n=1;
    for s=struct
        V=s(1);
        L=s(2);
        k = sqrt(2*(E-V));
        Ms = [cos(k*L) sin(k*L)/k; -k*sin(k*L) cos(k*L)];
        if (nargout==3) 
            P(:,n+1) = Ms*P(:,n); 
        else
            M=Ms*M;
        end
        n=n+1;
    end
    if (nargout ==3) 
        Pfinal = P(:,n);
    else
        Pfinal = M*init;
    end
    AB = T*Pfinal;
    
    A=AB(1);
    B=AB(2);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The plotbarriers function constitutes the wavefunction from the parts in
% each constant potential region.  This is then passed to the
% plotwavefunction function in order to display the final wavefunction and
% its probability density
function plotbarriers(E, Vext, struct, P)  
     structsize = sum(struct(2,:));
     x = -structsize:0.01*structsize:2*structsize;
     psi = zeros(size(x));
     n=1;
     L0=0;
     for s=struct
         V=s(1);
         L=s(2);
         k=sqrt(2*(E-V));
         T = 0.5*[ 1 -i/k; 1 +i/k];
         AB = T*P(:,n);
         sel = x>=L0 & x<L+L0;
         psi(sel) = AB(1)*exp(i*k*(x(sel)-L0)) + AB(2)*exp(-i*k*(x(sel)-L0));
         L0=L0+L;
         n=n+1;
     end 
     k= sqrt(2*(E-Vext));
     T = 0.5*[ 1 -i/k; 1 +i/k];
     AB = T*P(:,1);
     sel = x<0;
     psi(sel) = AB(1)*exp(i*k*(x(sel))) + AB(2)*exp(-i*k*(x(sel)));
     AB = T*P(:,n);
     sel = x>=L0;
     psi(sel) = AB(1)*exp(i*k*(x(sel)-L0)) + AB(2)*exp(-i*k*(x(sel)-L0));
     plotwavefunction(x, psi, E, struct, Vext);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function plots the wave function two ways.  First as lines showing
% the real and imaginary parts, then as an envelope given by the magnitude
% of the complex value and a color giving the phase angle.
function plotwavefunction(x, psi, E, struct, Vext)

    if nargin<3
        E=0;
    end
    if nargin<4
        struct = [];
    end

    sel=x>0 & x<sum(struct(2,:));
    psi=psi/max(abs(psi(sel)));

    prob = conj(psi).*psi;                  % cacluate probability density

    xs = [x(1) 0];                          % calculate the lines to represent  
    ys = [Vext Vext];                       % the potential barriers on graphs
    for s=struct
        xs = [xs xs(end) xs(end)+s(2)];
        ys = [ys s(1) s(1)];
    end
    xs = [xs xs(end) x(end)];
    ys = [ys Vext Vext];

    dx = (x(end)-x(1))/(length(x)-1);
    ylim = 2;
    clf                                     % clear the figure
    text(0.5,0.9,['Energy: ' num2str(E)]);

    subplot(2,1,1);                         % choose the upper plot
    plot(x, real(psi)+E, 'b','LineWidth',2);% plot the real part of the wavefunction
    line([x(1) x(end)],[E E],'Color','r');  % (here the wavefunctions are purely real)
    line(xs, ys,'Color','k','LineWidth',2);
    axis([x(1) x(end) -1 Vext+1]);          % set the axis limits 
    title(['Wavefunction for E=' num2str(E)]);
    
    subplot(2,1,2);                         % choose the lower plot
    plot(x, prob+E,'g','LineWidth',2);      % plot the probability density
    axis([x(1) x(end) -1 Vext+1]);          % set the axis limits
    line([x(1) x(end)],[E E],'Color','r');  % make a horizontal line
    line(xs, ys,'Color','k','LineWidth',2);
    title(['Probability for E=' num2str(E)]);
    drawnow
end
    