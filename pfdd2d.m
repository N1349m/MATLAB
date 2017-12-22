function pfdd2d(Niter,tauxy,obsstr,constraint,S,infile,outfile)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%File: pfdd2d.m
%
%Purpose: 2-dimensional Phase Field model for Dislocation Dynamics
%         solving Ginzburg-Landau (or Cahn-Hillard) equation
%         by finite difference method
%        
%   Section 11.4 A Two-dimensional Example
%         if constraint == 1 and obsstr == 0  (default)
%
%   Section 11.5 Dislocation-Alloy Interaction
%         if constraint == 0 and obsstr == 3.5   
%
%Computer Simulations of Dislocations
%Original Code by Wei Cai (caiwei@stanford.edu)
%Slightly Modified by Michael L. Falk (mfalk@jhu.edu) April 19,2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


N = 128;   % grid number
h = 1;     % grid size
dt = .5e-2; % time step
L = N*h;   % physical dimension
K = 1;     % relaxation rate
mu = 10;   % shear modulus
nu = 0.3;  % Poisson ratio
U = 1;     % Peierls energy
epsilon=4; % gradient energy

if nargin<1
	Niter = 2000;
end

if nargin<2
  tauxy = 0.45;    % applied shear stress, only useful when constraint = 0;
end

if nargin<3
  obsstr=0;  % strength of localized energy barrier (e.g. 0 or 3.5)
             % variable A in the book
end

if nargin<4
  constraint = 1;  % keep the total area of dislocation loop constant
end


if nargin<5
  S = 0;           % dislocation source
end

if nargin>=6 && ~isempty(infile)
    load(infile);
end

 
plotfreq = 500;
printfreq = 100;

% computation cell
x=[0:N-1]*h; z=x;

% energy barrier to slip
if (obsstr == 0)
  Uobs=U*ones(N,N);  %uniform Peierls energy
else
  % localized barrier to dislocation glide
  x0=44; z0=44; w0=4; %center and spread of obstacle  
  Uobs=exp(-(z-z0).^2/(2*w0^2))'*exp(-(x-x0).^2/(2*w0^2))*(obsstr-1)+1;
  x0=44; z0=84; w0=4; %center and spread of obstacle  
  Uobs=Uobs+exp(-(z-z0).^2/(2*w0^2))'*exp(-(x-x0).^2/(2*w0^2))*(obsstr-1);
  x0=84; z0=44; w0=4; %center and spread of obstacle  
  Uobs=Uobs+exp(-(z-z0).^2/(2*w0^2))'*exp(-(x-x0).^2/(2*w0^2))*(obsstr-1);
  x0=84; z0=84; w0=4; %center and spread of obstacle  
  Uobs=Uobs+exp(-(z-z0).^2/(2*w0^2))'*exp(-(x-x0).^2/(2*w0^2))*(obsstr-1);
  
end

%construct elastic energy kernel
if(~exist('Xi')|length(Xi)~=N)
  Xi=zeros(N,N);
  for i=1:N,
    for j=1:N,
        kx=i-1; kz=j-1;
        if(kx==0)&(kz==0)
            Xi(j,i)=0;
            continue;
        end
        if(i>N/2)
            kx=kx-N;
        end
        if(j>N/2);
            kz=kz-N;
        end
        kx=kx*(2*pi/N);
        kz=kz*(2*pi/N);
        Xi(j,i)=0.5/sqrt(kx^2+kz^2)*(kz^2+kx^2/(1-nu));
    end
  end
end

if(~exist('phi')|(length(phi)~=N))
%initial condition   
  phi=zeros(N,N); phi(N*3/8+1:N*5/8,N*3/8+1:N*5/8)=ones(N/4,N/4);
  Fdata=zeros(N,1);  
  Gdata=zeros(N,1);
end

pind=[2:N,1];
nind=[N,1:N-1];

%iteration begins
t = 0;
for iter = 1:Niter,
    phi1=phi;    
    phi1a=phi1;
    for subiter = 1:21,    
        [F,G,Eel,Epn,Egr]=Fphidd(phi1,Xi,mu,Uobs,epsilon,N,h);
        taucrit=sum(sum(G))/(N*N); %critical stress to maintain dislocation loop
        
        if(constraint==1)
            G=G-taucrit; %keep the total area of dislocation loop constant
        else
            G=G-tauxy;   %apply stress
            F=F-tauxy*sum(sum(phi));
        end

        G=G*(K);
        phi1a=phi1;
        phi1=phi - G*dt*0.5;
        dp=max(max(abs(phi1a-phi1)));
        if(~(dp>0) & ~(dp<0) ) disp('NaN'); return; end
        if(dp<1d-4) break; end
        if(subiter>20) 
            disp('iteration unstable reduce dt!'); break;
        end
    end

    grad = max(max(abs(G)));
    Fdata(iter)=F;
    Gdata(iter)=grad;

    % update phase field
    phi = phi - G*dt;
    t = t + dt;
    
    if(S~=0)  %dislocation source
        xs = [60:80]; ys = [60:80];
        phi(xs,ys) = 1 + S*t;
    end

    if(mod(iter,printfreq)==0)
        disp(sprintf('iter=%d F=%13.6e G=%13.6e si=%d Eel=%13.6e Epn=%13.6e Egr=%13.6e A=%13.6e',iter,F,grad,subiter,Eel,Epn,Egr,sum(sum(phi))));
    end

    if(mod(iter,plotfreq)==0)
        figure(1);
        subplot(1,2,1);
        contour(phi,[0.4 0.6 1.4 1.6 2.4 2.6 3.4 3.6 4.4 4.6 5.4 5.6 6.4 6.6 7.4 7.6 8.4 8.6 9.4 9.6 10.4 10.6]);
        hold on; contour(Uobs,[0.4 0.6]*obsstr); hold off
        axis equal; xlim([0,N*h]); ylim([0,N*h]); zlim([-1 1]);
        xlabel('x');ylabel('z');
        subplot(1,2,2);
        mesh(x,z,phi);
        %surf(phi);
        xlim([0,N*h]); ylim([0,N*h]);
        xlabel('x');ylabel('z');
        drawnow
        pause(0.2);
    end
end

% Plot results
figure(2);
subplot(1,1,1);
mesh(x,z,phi);
xlim([0,N*h]); ylim([0,N*h]);
xlabel('x');
ylabel('z');

figure(3);
plot([0:Niter-1]*dt,Fdata);
xlabel('t');
ylabel('F');

figure(4);
plot([0:Niter-1]*dt,Gdata);
xlabel('t');
ylabel('max(G)');

if nargin>=7 & ~isempty(outfile)
    save(outfile);
end
