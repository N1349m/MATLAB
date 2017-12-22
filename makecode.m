function [code] = makecode ()
Tempmatrix=[rand(1,26);65:90]'
Tempmatrix2=sortrows(Tempmatrix)'
Charmatrix=Tempmatrix2(2,1:26)
code=char(Charmatrix)
end