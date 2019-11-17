clc, clear all, close all;
%12 inch = 500 pixel
%1 inch = 500/12 pixel = 42 pixel
%Each camera has a viewing window 46inch*27.6inch = resolution 2000*1200 
%total viewing wind is 46+26+46inch = 118 inch = 5070 pixel
%camera placing vertically 6 inch apart, y = 6inch

ppi = 42; %pixel per inch
pix_x = 4920;
y = 6;
%pix_y is defined later

img_folder = strcat('C:\Users\mhossa89\Desktop\image processing folder\split averaged image\2 inch\B_');
A = readcell('combined_case.xlsx','Sheet','2inch');
%B = readcell('case.xlsx','Sheet','B');
%C = readcell('case.xlsx','Sheet','C');


for u_j = 2
    for u_cf = 4
        for cam = 1
            folder1 = strcat(img_folder,num2str(u_cf),'_',num2str(u_j),'_',num2str(cam),'.tif');
            folder2 = strcat(img_folder,num2str(u_cf),'_',num2str(u_j),'_',num2str(cam+1),'.tif');
            folder3 = strcat(img_folder,num2str(u_cf),'_',num2str(u_j),'_',num2str(cam+2),'.tif');
            img1 = imread(folder1);
            img2 = imread(folder2);
            img3 = imread(folder3);
            
            img_loc = strcat('C_',num2str(u_cf),'_',num2str(u_j));
            i = find(strcmp(A, img_loc));
            pix_y = 1200 + ([A{i,4}] - [A{i,2}])*y*ppi;

            averaged_image1 = zeros(pix_y,pix_x);
            averaged_image = uint8(averaged_image1);
            
           % if cam == 1              %first camera mapping 
                diff1 = ([A{i,4}] - [A{i,2}])*y*ppi;
                for k = 1:1920
                    for  kk = 1:1200
                        averaged_image(diff1+kk,k) = img1(kk,k);
                    end
                end
          %  end
            
          %  if cam == 2    %second camera mapping
                diff2 = ([A{i,4}] - [A{i,3}])*y*ppi;
                for k = 1:1080
                    for  kk = 1:1200
                        averaged_image(diff2+kk,1920+k) = img2(kk,420+k);
                    end
                end
          %  end
            
          %  if cam == 3     %third camera mapping
                diff3 = ([A{i,4}] - [A{i,4}])*y*ppi;
                for k = 1:1920
                    for  kk = 1:1200
                        averaged_image(diff3+kk,3000+k) = img3(kk,k);
                    end
                end
          %  end
        end
   
        jpgFileName = strcat('C_',num2str(u_cf),'_',num2str(u_j),'.tif');
        path = strcat('C:\Users\mhossa89\Desktop\image processing folder\combined averaged image\2 inch\',jpgFileName);
        imwrite(averaged_image,path);
    end
end