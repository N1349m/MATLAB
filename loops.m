function [output] = loops(innum)
innum =input('Enter number: ');
output=innum;
minnum = innum;
while innum>=minnum
    if innum>output
        output=innum;
    end
    innum =input('Enter number: ');
end
disp(num2str(output))
end