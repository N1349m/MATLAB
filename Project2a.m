function Project2a(V0, Q, maxtime, minT)
%Project2 solution written by Khalid Elawad
%A funcction that sets the initial T-cell count to 1, sets the initial
%infected T-cell count to 0 and initializes the initial viral load to V0.
%Then the function calls the Increment procedure until either the maxtime
%is exceeded or the total T-cell count (both infected and uninfected
%together) is less than minT. After each increment the day, T-cell count,
%infected T-cell count and viral load are saved in memory. Two graphs
%should be plotted, one showing the T and I values versus time and the
%other showing V values versus time. The function includes axis labels and a legend. Before the function ends the function displays the final time (day) of output, the final uninfeccted and infected T-cell counts and viral load to the screen.
t = 0;
T = 1;
I = 0;
V = V0;
Ttotal = T;
Itotal = I;
Vtotal = V;
TplusI = 1;
n = 1;
while t < maxtime && TplusI > minT
    
    [Tnext, Inext, Vnext] = Increment(Ttotal(n), Itotal(n), Vtotal(n), Q); 
    TplusI = Tnext + Inext;
    t = t+1;
    
    Ttotal(n+1) = Tnext;
    Itotal(n+1) = Inext;
    Vtotal(n+1) = Vnext;
    n = n+1;

end

fig=figure;
fig.Position=[500 100 570 880];

subplot(2,1,1); % Plotting T and I
plot(t,T,'b',t,I,'g');
xlabel('time');
ylabel('T-cell Count');
legend('Uninfected','Infected');

subplot(2,1,2); % Plotting V
plot(t,V,'b');
xlabel('time');
ylabel('Virus Level');

dayslength = length(Ttotal);
tfinal = dayslength - 1;
Tend = Ttotal(end);
Iend = Ttotal(end);
Vend = Vtotal(end);
FinalT = ['Final Uninfected T Cell Count: ',num2str(Tend)];
FinalI = ['Final Infected T Cell Count: ',num2str(Iend)];
FinalV = ['Final Viral Load: ',num2str(Vend)];
Finalday = ['Final Day ',num2str(tfinal)];

disp(FinalT);
disp(FinalI);
disp(FinalV);
disp(Finalday);

    function Tnext = NewT(T,V)
        % A subfunction which takes the current day’s T-cell count
        % and viral load and returns the T-cell count for the next
        % day.
        Tnext = T - 0.001*T*V;
        
    end
    function Inext = NewI(T, I, V)
        % A subfunction which takes the current day’s T-cell count,
        % viral load and count of infected T-cells and returns the
        % infected T-cell count for the next day.
        Inext = I + 0.001*T*V - 0.005*I;
    end
    function Vnext = NewV(T, I, V, Q)
        % A subfunction which takes the current day’s T-cell count,
        % viral load, count of infected T-cells and drug
        % effectiveness and returns the viral load on the
        % following day.
        Vnext = V + 10.0*(1-Q)*I - 0.05*V*T;
    end
    function [Tnext, Inext, Vnext]= Increment(T, I, V, Q)
        % A subfunction that takes the T-cell count, the viral load
        % and the infected T-cell count and increments them all by
        % one day.
        % Be careful that all increments are calculated using
        % values from the previous day! This procedure must call
        % the three subfunctions above.
        Tnext = NewT(T, V);
        Inext = NewI(T, I, V);
        Vnext = NewV(T, I, V, Q);
    end
end
    



