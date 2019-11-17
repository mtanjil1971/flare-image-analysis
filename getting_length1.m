clc,clear all, close all;
A_dir = dir('C:\Users\mhossa89\Desktop\image processing folder\combined averaged image\result 30 august');
A = readcell('combined_case.xlsx','Sheet','AA');
stack_loc = readcell('combined_case.xlsx','Sheet','loc');
stack_loc2 = xlsread('combined_case.xlsx','loc');
for j = 20
        folder = strcat(A_dir(j).folder, '\' ,A_dir(j).name);
        img = A_dir(j).name
        i = find(strcmp(A, img));
        ij = [A{i,2}];
        [ip jp]= find(stack_loc2(:,1)== ij);
        ii = ip;
        %ii = find(contains(stack_loc,ij));
        p = imread(folder);
        x1 = [stack_loc{ii,3}];
        y1 = [stack_loc{ii,2}];
        x2 = [stack_loc{ii,5}];
        y2 = [stack_loc{ii,4}];
        
        x1_mod = length(p(:,1)) - 1200 + x1;
        for m = x1_mod : 1 : length(p(:,1))
            for n = [y1 y2]
                p(m,n) = 250;
            end
        end
        %% tail measurement
        new_p = zeros(length(p(:,1)),length(p(1,:)));
        for row = 6: length(p(:,1))-5
            for col = 10:length(p(1,:))-10
                val = box(row,col,p);
                new_p(row,col) = val;
            end
        end
        
        figure('visible','off')
        imshowpair(p,new_p,'montage')
        %imtool(p)
        %imtool(new_p)
        [row1 col1] = find(new_p == 1);
        y3 = max(col1);
        [idx,idy]=find(col1== y3);
        index_max3 = max(idx);
        x_start = x1_mod;
        y_start =round((y1+y2)/2);
        x_end = row1(index_max3) + 5;
        y_end = col1(index_max3) + 9;
        [A{i,5}] = x_start;
        [A{i,6}] = y_start;
        [A{i,7}] = x_end;
        [A{i,8}] = y_end;
        flame_length = ((x_start - x_end).^2 + (y_start - y_end).^2).^0.5 .* 0.06096;
        f_l = int2str(flame_length);
        [A{i,9}] = flame_length;
        jpgFileName = strcat(A_dir(j).name);
        abul = strcat('Flame length : ',f_l,' cm');
        figure('visible','off')
        imshow(p)
        hold on
        abul = strcat('Flame length is:',f_l,'cm');
        h = drawline('Position',[y_start x_start;y_end x_end]);
        p = insertText(p, [4000 1400], abul, 'Font','Times','fontsize',75,'BoxColor','w');
        print(gcf, jpgFileName, '-dpng', '-r300');
        imtool(p)
        hold off
        %%
        path = strcat('C:\Users\mhossa89\Desktop\image processing folder\combined averaged image\stack\',jpgFileName);
        imwrite(p,path);
        close(figure)
end