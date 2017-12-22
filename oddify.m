function newm= oddify(oldm)
 
    q = mod(oldm,2)==0;
    newm=oldm;
    newm(q)=oldm(q)+1;