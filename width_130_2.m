function [x] = width130_2(row,col,p)
if p(row,col)== 128 && p(row-1,col)== 128 && p(row-2,col)== 128
    x = 5;
    return
else
    x = 0;
    return
end