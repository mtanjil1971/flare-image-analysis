function [x] = width26_2(row,col,p)
if p(row,col)== 26 && p(row-1,col)== 26 && p(row-2,col)== 26
    x = 5;
    return
else
    x = 0;
    return
end