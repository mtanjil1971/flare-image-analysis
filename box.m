function [x] = box(row,col,p)

for ib = (row - 5):1:(row+5)
    for jb = (col-9):1:(col+9)
        if p(ib,jb)== 0
            x = 0;
            return
        end
    end
end


x = 1;
return