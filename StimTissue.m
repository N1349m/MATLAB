function U = StimTissue(U, r, c)
% Takes an N x N array and stimulates a circular region with radius N/8
% centered at row r and column c by setting the values of U in that
% region to 0.8
N=length(U);
for x=1:N
    for y=1:N
        if (x-r)^2+(y-c)^2<=N^2/64 % Defines the area inside the circle
            U(x,y)=0.8;
        end
    end
end
end
