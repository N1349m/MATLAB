function RandomWalk2(N,M)
%Lakyn Mayo

%Program that simulates a 1-dimensional random walk
%N is the number of steps (for the project, we need 250, 500, and 1000)
%M is the number of particles, which should just be larger than 250

%create matrix of the size of N that is filled with zeroes and ones
%randomly


%initialize position as empty vector


finalpos=zeros(1,M);

for j=1:M
    
    pos=0;
    
    for i=1:N
        RandN=randi([0,1],[1,N]);
        %1 is equivalent to heads, 0 is equivalent to tails
        if RandN(i)==1
            pos=pos+1;
        end
        if RandN(i)==0
            pos=pos-1;
        end
    end
    
    finalpos(j)=pos;
    
end

histfit(finalpos)




end