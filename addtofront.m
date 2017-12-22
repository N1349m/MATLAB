function newlist = addtofront(this)

 global Q
 Q = [this Q];
 newlist = Q;
end