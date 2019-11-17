clc,clear all,close all;
A = load('1_inch_width_calculation_result.mat');
A_dir = dir('C:\Users\mhossa89\Desktop\flare\aug exp 19\result 30 august');
for u_j = 4
    for u_cf = 8
        folder1 = strcat('A_',num2str(u_cf),'_',num2str(u_j),'.tif');
        folder2 = strcat('B_',num2str(u_cf),'_',num2str(u_j),'.tif');
        folder3 = strcat('C_',num2str(u_cf),'_',num2str(u_j),'.tif');

        [ia ja] = find(strcmp(A.A, folder1));
        [ib jb] = find(strcmp(A.A, folder2));
        [ic jc] = find(strcmp(A.A, folder3));
        
        xxr = 0;
        xxg = 0;
        xxb = 0;
        pix_size = 0.06096; %pixel size of individual images
        case_a_26_1 = abs(A.A{ia,2}.*pix_size/2.54)+xxr; %column 6 contains average width data
        case_b_26_1 = abs(A.A{ib,2}.*pix_size/2.54)+xxg;
        case_c_26_1 = abs(A.A{ic,2}.*pix_size/2.54)+xxb;
        case_a_26_2 = abs(A.A{ia,3}.*pix_size/2.54)+xxr; %column 6 contains average width data
        case_b_26_2 = abs(A.A{ib,3}.*pix_size/2.54)+xxg;
        case_c_26_2 = abs(A.A{ic,3}.*pix_size/2.54)+xxb;
        x_a_26(:,1) = (1:length(case_a_26_1(:,1))-181)*pix_size/2.54; % 0.06096 is the size of a pixel value
        x_b_26(:,1) = (1:length(case_b_26_1(:,1))-181)*pix_size/2.54;
        x_c_26(:,1) = (1:length(case_c_26_1(:,1))-181)*pix_size/2.54;
        
        area_a_10 = round(A.A{ia,8} *pix_size*pix_size);
        area_b_10 = round(A.A{ib,8} *pix_size*pix_size);
        area_c_10 = round(A.A{ic,8} *pix_size*pix_size);
        
        area_a_50 = round(A.A{ia,9} *pix_size*pix_size);
        area_b_50 = round(A.A{ib,9} *pix_size*pix_size);
        area_c_50 = round(A.A{ic,9} *pix_size*pix_size);
        
        
        Area_a_10 = strcat('- A : ',num2str(area_a_10),' cm^2');
        Area_b_10 = strcat('- B : ',num2str(area_b_10),' cm^2');
        Area_c_10 = strcat('- C : ',num2str(area_c_10),' cm^2');
        Area_a_50 = strcat('- A : ',num2str(area_a_50),' cm^2');
        Area_b_50 = strcat('- B : ',num2str(area_b_50),' cm^2');
        Area_c_50 = strcat('- C : ',num2str(area_c_50),' cm^2');        
        
        
        
        titletext = strcat('U_\infty',' = ',num2str(u_cf),' m/s ',' - ',' U_j',' = ',num2str(u_j),' m/s');
        titletext2 = strcat(num2str(u_cf),'_',num2str(u_j));
        
        y_cent = 20;
        
        figure
%       plot(x_a_26,case_a_26_1(401:end),'r.',x_a_26,case_a_26_2(401:end),'r.',x_b_26,case_b_26_1(401:end),'g.',x_b_26,case_b_26_2(401:end),'g.',x_c_26,case_c_26_1(401:end),'.b',x_c_26,case_c_26_2(401:end),'.b');
        xs = 2500;
        xz = 181+xs-1;
        %plot(x_a_26(1:xs),case_a_26_1(181:xz),'.r',x_a_26(1:xs),case_a_26_2(181:xz),'.r',x_b_26(1:xs),case_b_26_1(181:xz),'.g',x_b_26(1:xs),case_b_26_2(181:xz),'.g',x_c_26(1:xs),case_c_26_1(181:xz),'.b',x_c_26(1:xs),case_c_26_2(181:xz),'.b');
        plot(x_a_26(1:end),case_a_26_1(182:end),'.r',x_a_26(1:end),case_a_26_2(182:end),'.r',x_b_26(1:end),case_b_26_1(182:end),'.g',x_b_26(1:end),case_b_26_2(182:end),'.g',x_c_26(1:end),case_c_26_1(182:end),'.b',x_c_26(1:end),case_c_26_2(182:end),'.b');
        set(gca,'YDir','reverse');
        daspect([1 1 1])
        hold on
        xlabel('X/d');
        ylabel('Y/d');
        xlim([0 104]);
        ylim([0 50]);
        yticks([y_cent-20 y_cent-15 y_cent-10 y_cent-5 y_cent y_cent+5 y_cent+10 y_cent+15 y_cent+20 y_cent+25]);
        yticklabels({'20','15','10','5','0','-5','-10','-15','-20','-25'});
        grid on;
        txt1 = {'Area(10% contour)',Area_a_10,Area_b_10,Area_c_10};
        %text(5,7,txt1,'FontSize',12);
        txt2 = {'Area(50% contour)',Area_a_50,Area_b_50,Area_c_50};
        %text(35,7,txt2,'FontSize',12);
        %lgend = legend('Case A','Case B','Case C');
        %set(lgend,'color','none','Location','northeast');
        title(titletext);
        set(gca,'Fontsize', 20,'FontName', 'Times');
        set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 2500 1000]/200);
        print(gcf, titletext2, '-dpng', '-r300');
        hold off;
        
        case_a_26_1 = [];% abs(A.A{ia,2}.*pix_size/2.54)+xxr; %column 6 contains average width data
        case_b_26_1 = [];% abs(A.A{ib,2}.*pix_size/2.54)+xxg;
        case_c_26_1 = [];%abs(A.A{ic,2}.*pix_size/2.54)+xxb;
        case_a_26_2 = [];%abs(A.A{ia,3}.*pix_size/2.54)+xxr; %column 6 contains average width data
        case_b_26_2 = [];%abs(A.A{ib,3}.*pix_size/2.54)+xxg;
        case_c_26_2 = [];%abs(A.A{ic,3}.*pix_size/2.54)+xxb;
        x_a_26 = [];%(1:length(case_a_26_1(:,1))-181)*pix_size/2.54; % 0.06096 is the size of a pixel value
        x_b_26 = [];%(1:length(case_b_26_1(:,1))-181)*pix_size/2.54;
        x_c_26 = [];%(1:length(case_c_26_1(:,1))-181)*pix_size/2.54;
    end
end