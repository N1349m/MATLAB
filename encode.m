function [out] = encode( message , code)
code=code-'0'-48;
message=message-'0'-48;
len=length(message);
for x=1:1:len
    message(1,x)=code(1,message(1,x));
end
message=message+96;
out=char(message);
end

