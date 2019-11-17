clear all,clc;
writerObj = VideoWriter('C:\Users\mhossa89\Desktop\flare\conditional averaging\whitebackground\raw1_1s.avi'); %creating a movie object
writerObj.FrameRate = 1; %set frame rate

open(writerObj); % Open video writer object and write frames sequentially


        folder2 = strcat('C:\Users\mhossa89\Desktop\flare\conditional averaging\whitebackground\1', '\');
        files = dir(fullfile(folder2, '*.jpg'));
        idxx = 1;
        for k =1:length(files)
            name = strcat(folder2, files(k).name);
           % frame = sprintf(name); % Read frame
            input = imread(name);
            writeVideo(writerObj, input); % Write frame no
        end
        
        close(writerObj);