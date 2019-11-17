tic
clc, close all; clear all;
photo = imread('C:\Users\mhossa89\Desktop\image processing folder\Case A\A_2_2\1\16-38-22.332.tif');
figure
imshow(photo)
p = rgb2gray(photo);
figure
imshow(p);
title('raw image')
figure
[y,x] = imhist(p);
plot(x,y);
set(gca, 'XScale', 'log', 'YScale', 'log');
%% first derivative 
dy=diff(y)./diff(x);
figure,
plot(x(2:end),dy);

%% min value of y from first derivative
[r, c] = find(ismember(dy, min(dy(:))));


%% to enhance the intensity of the image without considering the dark part
q = im2double(p);
for i = 1:length(q(:,1))
    for j = 1:length(q(1,:))
        if p(i,j) <15
            q(i,j)= 0;
        else
            q(i,j) = 2*log(1+q(i,j));
        end
    end
end
pp = uint8(255 * mat2gray(q));
figure 
imshow(q);
title('double image');

figure
imshow(pp);
title('unit image');
%% compare the intensity level of the raw and edited image
[yy,xx] = imhist(pp);
plot(xx,yy,x,y);
set(gca, 'XScale', 'log', 'YScale', 'log');

med = medfilt2(pp);

figure
imshow(med);
title('filtered image');

idx=med==0;     %counting the number of zeroes in a matrix
idx2=pp==0;
pp_out=sum(idx2(:));
med_out=sum(idx(:));

%% convert to binary value

g = zeros(i,j);
for i = 1:length(pp(:,1))
    for j = 1:length(pp(1,:))
        if pp(i,j) < 25
            g(i,j)= 0;
        else
            g(i,j) = 1;
        end
    end
end
toc
figure
imshow(g);
title('binarizedd image');
imtool(g)
abb = zeros(i,j);
for i = 2:length(g(:,1))-1
    for j = 2:length(g(1,:))-1
        if g(i,j)== 1
            if  [g(i-1,j)&& g(i-1,j-1)&& g(i,j-1)] ==1 || [g(i-1,j) && g(i-1,j+1) && g(i,j+1)] ==1 || [g(i,j+1) && g(i+1,j+1) && g(i+1,j)] == 1 || [g(i+1,j) && g(i+1,j-1) && g(i,j-1)] ==1 ||[g(i-1,j) && g(i,j-1) && g(i+1,j) && g(i,j+1)] ==1 || [g(i-1,j-1) && g(i+1,j-1) && g(i+1,j+1) && g(i-1,j+1)] ==1 ||[g(i-1,j) && g(i,j+1) && g(i+1,j)] == 1 || [g(i,j+1) && g(i+1,j) && g(i,j-1)] ==1 || [g(i,j+1) && g(i+1,j) && g(i,j-1)] == 1 || [g(i+1,j) && g(i,j-1) && g(i-1,j)] == 1 || [g(i,j-1) && g(i-1,j) && g(i,j+1)] ==1
                abb(i,j) = 1;
            else
                abb(i,j) = 0;
            end
        end
    end
end

figure
imshow(abb)
title('complex binarized image');