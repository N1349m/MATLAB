function [that,thing] = holla(this,theother)

 function newer = changeit(older)
 newer = older;
 newer(1) = upper(newer(1));
 newer = [newer stopper];
 stopper = '?';
 end
 stopper = '!';
 that = changeit(this);
 thing = hoohah(changeit(theother))
end
function x = hoohah(y)
 y = y(2:end);
 x = changeit(y);
end
function outstring = changeit(instring)
 outstring = instring;
 outstring(1:2) = lower(outstring(1:2));
 outstring = [outstring '.'];
end