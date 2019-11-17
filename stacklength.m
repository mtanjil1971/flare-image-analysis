clear all;close all; clc;
A_dir = dir('F:\image acquired Auguest 2019\case A');
for j= 21
    folder = strcat(A_dir(j).folder, '\' ,A_dir(j).name);
for i = 4
    folder2 = strcat(folder,'\',int2str(i));
    folder2 = strcat(folder2, '\');
    files = dir(fullfile(folder2, '*.tif'));
    idxx = 1;
    no_of_files = floor(length(files)/10);
    
    for k =1:10:length(files)
    name = strcat(folder2, files(k).name);
    photo = imread(name);
    p = rgb2gray(photo);
        
    [y,x] = imhist(p); %generating histogram line 
    %% first derivative 
    dy=diff(y)./diff(x);

    %% second derivative
    d2y = diff(y,2)./diff(x,2);

    %% min value of y from first derivative
    [r, c] = find(ismember(dy, min(dy(:))));


    %% to enhance the intensity of the image without considering the dark part
    q = im2double(p);
        for l = 1:length(q(:,1))
            for m = 1:length(q(1,:))
                if p(l,m) < x(r+1)
                    q(l,m)= 0;
                else
                        q(l,m) = 2*log(1+q(l,m));
            end
                end
        end
            
     pp = uint8(255 * mat2gray(q));


     %% compare the intensity level of the raw and edited image
     [yy,xx] = imhist(pp);

     med = medfilt2(pp); %preliminary elimination of salt and pepper image

     %% convert to binary value

     g = zeros(l,m);
     for l = 1:length(pp(:,1))
         for m = 1:length(pp(1,:))
             if p(l,m) < 15
                 g(l,m)= 0;
             else
                 g(l,m) = 1;
             end
         end
     end
            
%             tan = i;
%            
%             i = l;
%             j = m;
%             
%             abb = zeros(i,j);
%             for i = 2:length(g(:,1))-1
%                 for j = 2:length(g(1,:))-1
%                     if g(i,j)== 1
%                         if  [g(i-1,j)&& g(i-1,j-1)&& g(i,j-1)] ==1 || [g(i-1,j) && g(i-1,j+1) && g(i,j+1)] ==1 || [g(i,j+1) && g(i+1,j+1) && g(i+1,j)] == 1 || [g(i+1,j) && g(i+1,j-1) && g(i,j-1)] ==1 ||[g(i-1,j) && g(i,j-1) && g(i+1,j) && g(i,j+1)] ==1 || [g(i-1,j-1) && g(i+1,j-1) && g(i+1,j+1) && g(i-1,j+1)] ==1 ||[g(i-1,j) && g(i,j+1) && g(i+1,j)] == 1 || [g(i,j+1) && g(i+1,j) && g(i,j-1)] ==1 || [g(i,j+1) && g(i+1,j) && g(i,j-1)] == 1 || [g(i+1,j) && g(i,j-1) && g(i-1,j)] == 1 || [g(i,j-1) && g(i-1,j) && g(i,j+1)] ==1
%                             abb(i,j) = 1;
%                         else
%                             abb(i,j) = 0;
%                         end
%                     end
%                 end
%             end
%             
%             i = tan;
            
     abbcell{idxx} = g;         
     idxx = idxx+1;  
     end
        
        
    %% sum of all binaray value
    sum =0;
    for n = 1:no_of_files
        sum = sum + abbcell{n};
    end
    avg = sum/no_of_files;
    %figure
        %imshow(avg)
    width = [length(avg(:,1)) length(avg(1,:))];
    for ll = 1:length(avg(:,1))
        for mm = 1:length(avg(1,:))
            if avg(ll,mm)== 1
                width(ll,mm) = 1;
            elseif avg(ll,mm)<1 && avg(ll,mm)>= 0.50
                width(ll,mm) = 0.5;
            elseif avg(ll,mm)<0.50 && avg(ll,mm)>= 0.10
                width(ll,mm) = 0.10;
            else
                width(ll,mm) = 0;
            end
        end
    end
    tan = i;
    jpgFileName = strcat(A_dir(j).name,'_', num2str(tan), '.tif');
    path = strcat('C:\Users\mhossa89\Desktop\image processing folder\split averaged image\case A\',jpgFileName);
    imwrite(width,path);
    %figure
    %imshow(width2);        
end
end