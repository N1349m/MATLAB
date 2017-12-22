function [reflect_angle] = snell (index_1, index_2, incidence_angle)
if (index_2>index_1)
    reflect_angle=asin(index_1*sin(incidence_angle)/index_2);
else
    temp=index_1*sin(incidence_angle)/index_2;
    if (temp>1 || temp<-1)
        reflect_angle=2*pi-incidence_angle;
    else
        reflect_angle=asin(index_1*sin(incidence_angle)/index_2);
    end
end    
disp(['The angle of reflection is ', num2str(reflect_angle)]);
end