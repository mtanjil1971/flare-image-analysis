% image binarization code%

clear all;close all; clc;
A_dir = dir('F:\2 inch\case A');
A = readcell('combined_case.xlsx','Sheet','2inch');
for j = [6]
%for j= [3 6 7 8 11 12 13 16 17 18 21 22 23 26 27]
    folder = strcat(A_dir(j).folder, '\' ,A_dir(j).name);
    img_loc = A_dir(j).name
    i_num = find(strcmp(A, img_loc));
for i = 2
    folder2 = strcat(folder,'\',int2str(i));
    folder2 = strcat(folder2, '\');
    files = dir(fullfile(folder2, '*.tiff'));
    idxx = 1;
    no_of_files = floor(length(files)/5);
    
    for k =1:5:length(files)
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
    q = medfilt2(p,[5 8]);

     %% convert to binary value
     g = zeros(1200,1920); %based on resolution of the image
     for l = 1:length(p(:,1))
         for m = 1:length(p(1,:))
             if p(l,m) < [A{i_num,5}]
                 g(l,m)= 0;
             else
                 g(l,m) = 1;
             end
         end
     end
           
            
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
    path = strcat('C:\Users\mhossa89\Desktop\image processing folder\split averaged image\2 inch\',jpgFileName);
    imwrite(width,path);
    %figure
    %imshow(width2);        
end
end