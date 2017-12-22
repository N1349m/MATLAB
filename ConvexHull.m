function [Gmin,Phases] = ConvexHull(x,G1,w1,G2,w2)
% ConvexHull takes three vectors of equal length
% that contain a range of compositions from 0 to 1
% and the free energy of each phase over this range
% as well as the accompanying values of w for each
% phase. The function returns the minimum free
% energy and the number (1 or 2) designating the
% most stable pure phase at each
% composition or 3 if the mixture is more stable.

GA1=G1(end); %GA1 is the free energy with 100% pure A in Phase 1
GB1=G1(1); %GB1 is the free energy with 100% pure B in Phase 1
GA2=G2(end); %GA2 is the free energy with 100% pure A in Phase 2
GB2=G2(1); %GB2 is the free energy with 100% pure B in Phase 2

deltaG=GA1-GB1-GA2+GB2;
barG=GA1+GB1-GA2-GB2;

% Setting the array for Gmin without the tangent line
Gmin=zeros(1,length(x));
Phases=zeros(1,length(x));
for w=1:length(x)
    if G1(w)<G2(w)
        Gmin(w)=G1(w);
        Phases(w)=1;
    else
        Gmin(w)=G2(w);
        Phases(w)=2;
    end
end

%Finds y-values for G1 curve
    function [Gval]= Frenergy1(t)
        Gval=GB1+(GA1-GB1).*t-w1*t.*(1-t);
    end

%Finds y-values for G2 curve
    function [Gval]= Frenergy2(t)
        Gval=GB2+(GA2-GB2).*t-w2*t.*(1-t);
    end

% Calculating the tangent line
if w1==w2
    x1=(1-barG/deltaG-deltaG/2/w1)/2;
    x2=(1-barG/deltaG+deltaG/2/w1)/2;
    if x1>0 && x1<1 && isreal(x1)==1 && x2>0 && x2<1 && isreal(x2)==1 %Makes sure x values are valid
        slope=(Frenergy2(x2)-Frenergy1(x1))/(x2-x1);
        intercept=Frenergy2(x2)-slope*x2;
        if x2<x1 %Makes sure x1 is less than x2
            temp=x2;
            x2=x1;
            x1=temp;
        end
        xmin=floor(x1*100)+1; %Sets bounds for which GMin values need to be rewritten
        xmax=floor(x2*100);
        for j=xmin:1:xmax
            Gmin(j)=slope*(x1+(j-xmin-1)*0.01)+intercept;
            Phases(j)=3;
        end
    end
else
    det=(1-2*barG/(w1-w2)+(deltaG/(w1-w2))^2);
    x1a=(1-deltaG/(w1-w2)+sqrt(w2/w1*det))/2;
    x1b=(1-deltaG/(w1-w2)-sqrt(w2/w1*det))/2;
    x2a=(1-deltaG/(w1-w2)+sqrt(w1/w2*det))/2;
    x2b=(1-deltaG/(w1-w2)-sqrt(w1/w2*det))/2;
    
    %Testing the x values to see which ones are good
    if isreal(x1a)==0
        x1a=-1;
    end
    if x1a<0 || x1a>1
        x1a=-1;
    end
    if isreal(x1a)==0
        x1a=-1;
    end
    if x1b<0 || x1b>1
        x1b=-1;
    end
    if isreal(x2a)==0
        x2a=-1;
    end
    if x2a<0 || x2a>1
        x2a=-1;
    end
    if isreal(x2b)==0
        x2b=-1;
    end
    if x2b<0 || x2b>1
        x2b=-1;
    end
    
    
    slope1a=GA1-GB1-w1*(1-2*x1a);
    slope1b=GA1-GB1-w1*(1-2*x1b);
    slope2a=GA2-GB2-w2*(1-2*x2a);
    slope2b=GA2-GB2-w2*(1-2*x2b);
    
    tempmatrix=[x1a x1b; x2a x2b];
    SlopeMatrix=[slope1a slope1b; slope2a slope2b];
    
    %Sets up a matrix cointing pairs of points that form tangent lines
    PointMatrix=[];
    for m=1:2
        if tempmatrix(1,m)~=-1 %Prevents function from running if x was disqualified earlier
            if tempmatrix(2,1)~=-1 && abs(SlopeMatrix(1,m)-slope2a)<0.001
                PointMatrix=[PointMatrix;tempmatrix(1,m) x2a];
            elseif tempmatrix(2,2)~=-1 && abs(SlopeMatrix(1,m)-slope2b)<0.001
                PointMatrix=[PointMatrix;tempmatrix(1,m) x2b];
            end
        end
    end
    
    for n=1:2
        if size(PointMatrix)~=0
            x1=PointMatrix(3-n,1);
            x2=PointMatrix(3-n,2);
            if x1~=0
                slope=(Frenergy2(x2)-Frenergy1(x1))/(x2-x1);
                intercept=Frenergy2(x2)-slope*x2;
                if x2<x1 %Makes sure x1 is less than x2
                    temp=x2;
                    x2=x1;
                    x1=temp;
                end
                xmin=floor(x1*100)+1;
                xmax=floor(x2*100);
                
                for j=xmin:1:xmax
                    Gmin(j)=slope*(x1+(j-xmin-1)*0.01)+intercept;
                    Phases(j)=3;
                end
            end
        end
    end
end
end