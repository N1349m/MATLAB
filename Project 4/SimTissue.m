function SimTissue(N, T, stime, ptime, D, dt)
% Simulates a tissue that is represented by two NxN arrays. The
% simulation lasts T time steps. It is initially set up with a
% stimulus at the center using InitTissue. Every stime steps a randomly
% located region of radius N/8 is electrically stimulated. The values
% in U should be plotted as a pcolor plot every ptime steps.

[U,V]=InitTissue(N); % Initializes U and V

for time=1:T
    
    [NewU,NewV]=StepTissue(U, V, D, dt); % Increments StepTissue
    [U,V]=deal(NewU,NewV);
    if floor(time/stime)==time/stime % Checks if stime steps have passed
        r=randi(N);
        c=randi(N);
        U=StimTissue(U, r, c);
    end
    if floor(time/ptime)==time/ptime % Checks if ptime steps have passed
        figure;
        colorbar;
        caxis([0,1]);
        shading flat;
        pcolor(U)
    end
end
end