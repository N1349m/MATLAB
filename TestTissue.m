function TestTissue(N, T, stime, r, c, ptime, D, dt)
% Simulates a tissue that is represented by two NxN arrays. The
% simulation lasts T time steps. It is initially set up with a
% stimulus at the center using InitTissue. Once, after stime steps,
% a region centered on row r and column c of radius N/8 is
% stimulated. The values in U should be plotted as a pcolor plot
% every ptime steps.
[U,V]=InitTissue(N); % Initializes U and V
Ustore=[U];
Vstore=[V];
for time=1:T
    [U,V]=StepTissue(U, V, D, dt);
    if time==stime
        U=StimTissue(U, r, c);
    end
    U=abs(U);
    V=abs(V);
    Ustore=[Ustore;U];
    Vstore=[Vstore;V];
    if floor(time/ptime)==time/ptime
        figure
        colormap copper(20)
        pcolor(U);
        hold on
    end
end
end