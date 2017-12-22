function [madelungc] = madelung(n,type)
% Calculates Madelung constant in 3 dimensions
% By Nikhil Menon
madelungc=0; %Final output
for i=-n:n
    for j=-n:n
        for k=-n:n
            if i==0 && j==0 && k==0 %Doesn't change constant if testing the original atom
                madelungc=madelungc;
            elseif type == 1
                if i^2+j^2+k^2<=n^2 % Checks if point is within radius of circle
                    madelungc=madelungc+(-1)^(i+j+k)/sqrt(i^2+j^2+k^2);
                end
            else
                madelungc=madelungc+(-1)^(i+j+k)/sqrt(i^2+j^2+k^2);
            end
        end
    end
end