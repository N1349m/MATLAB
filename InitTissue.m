function [U, V] = InitTissue(N)
% This function will create an initial condition where U and V are
% N x N arrays that are zero everywhere except for a circle of radius
% N/8 centered at row (N+1)/2 and col (N+1)/2 which should have U=0.8.
% Use the StimTissue procedure defined above.
U=zeros(N,N);
V=zeros(N,N);
r=(N+1)/2;
U=StimTissue(U,r,r); % Calls StimTissue, previosuly defined
end