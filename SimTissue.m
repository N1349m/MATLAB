function SimTissue(N, T, stime, ptime, D, dt)
% Simulates a tissue that is represented by two NxN arrays. The
% simulation lasts T time steps. It is initially set up with a
% stimulus at the center using InitTissue. Every stime steps a randomly
% located region of radius N/8 is electrically stimulated. The values
% in U should be plotted as a pcolor plot every ptime steps.

[U,V]=InitTissue(N); % Initializes U and V

for time=1:T
    
    [NewU,NewV]=StepTissue(U, V, D, dt);
    [U,V]=deal(NewU,NewV);
    U=abs(U);
    V=abs(V);
    if floor(time/stime)==time/stime
        r=randi(N);
        c=randi(N);
        U=StimTissue(U, r, c);
    end
    if floor(time/ptime)==time/ptime
        figure;
        colormap copper(20);
        pcolor(U);
    end
    
end
end