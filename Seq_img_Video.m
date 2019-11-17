clear all, close all; clc;
writerObj = VideoWriter('C:\Users\mhossa89\Desktop\image processing folder\Case C\C_6_2\Cam 1.avi'); %creating a movie object
writerObj.FrameRate = 5; %set frame rate

open(writerObj); % Open video writer object and write frames sequentially


        folder2 = strcat('C:\Users\mhossa89\Desktop\image processing folder\Case C\C_6_2\1', '\');
        files = dir(fullfile(folder2, '*.tif'));
        idxx = 1;
        for k =1:1000
            name = strcat(folder2, files(k).name);
            photo = imread(name);
            p = 2*photo;
            %frame = sprintf(name); % Read frame
            input = p;
            writeVideo(writerObj, input); % Write frame no
        end
        
        close(writerObj);