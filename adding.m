function newlist = adding(this)
Q=this;
limit=input('How many numbers? ')-1;
while limit>0
addnum=input('Next number: ');
prompt=input('Front or back?', 's');
if strcmp(prompt, 'front') == 1
    Q=addtofront(Q, addnum);
elseif strcmp(prompt, 'back') == 1
    Q=addtoback(Q, addnum);
end
limit=limit-1;
end
newlist = Q;
end

function newlist = addtofront(Q, this)
 Q = [this Q];
 newlist = Q;
end

function newlist = addtoback(Q, this)
 Q = [Q this];
 newlist = Q;
end