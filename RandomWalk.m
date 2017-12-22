function RandomWalk(nummol)
% By Nikhil Menon
% Simulates a random walk for a given number of molecules
% at time steps of 250, 500, and 1000

% Initializes the 
finalpos250=zeros(1,nummol);
finalpos500=zeros(1,nummol);
finalpos1000=zeros(1,nummol);

%simulates the movement of nummol molecules for 250 steps
for index1=1:nummol
    for index2=1:250
        i=rand(1);
        if i>=0.5
            finalpos250(index1)=finalpos250(index1)+1;
        else
            finalpos250(index1)=finalpos250(index1)-1;
        end
    end
end

%simulates the movement of nummol molecules for 500 steps
for index1=1:nummol
    for index2=1:500
        i=rand(1);
        if i>=0.5
            finalpos500(index1)=finalpos500(index1)+1;
        else
            finalpos500(index1)=finalpos500(index1)-1;
        end
    end
end

%simulates the movement of nummol molecules for 1000 steps
for index1=1:nummol
    for index2=1:1000
        i=rand(1);
        if i>=0.5
            finalpos1000(index1)=finalpos1000(index1)+1;
        else
            finalpos1000(index1)=finalpos1000(index1)-1;
        end
    end
end
% plots the data with a normal distribution curve
fig=figure;
fig.Position=[500 100 1350 580];

subplot(1,3,1)
histfit(finalpos250);
xlabel('X distance');
ylabel('Number of Molecules');

subplot(1,3,2)
histfit(finalpos500)
xlabel('X distance');
ylabel('Number of Molecules');

subplot(1,3,3)
histfit(finalpos1000)
xlabel('X distance');
ylabel('Number of Molecules');

% Tests how good of a fit a normal
% distribution is to the data
x=chi2gof(finalpos250);
y=chi2gof(finalpos500);
z=chi2gof(finalpos1000);

%   Displays whether or not the data fits a normal distribution
if x==0
    formatSpec='The data fits a normal distribution for t=250\n';
else
    formatSpec='The data does not fit a normal distribution for t=250\n';
end
    fprintf(formatSpec);

if y==0
    formatSpec='The data fits a normal distribution for t=250\n';
else
    formatSpec='The data does not fit a normal distribution for t=250\n';
end
fprintf(formatSpec);

if z==0
    formatSpec='The data fits a normal distribution for t=250\n';
else
    formatSpec='The data does not fit a normal distribution for t=250\n';
end
fprintf(formatSpec);
end