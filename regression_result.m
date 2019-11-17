clc,clear all,close all;


%% reading experimental data of flame length from excel file 
A = xlsread('length_new.xlsx','regression_result_new');
in1_uj_1 = xlsread('length_separate_result.xlsx','1in_1');
in1_uj_2 = xlsread('length_separate_result.xlsx','1in_2');
in1_uj_3 = xlsread('length_separate_result.xlsx','1in_3');
in1_uj_4 = xlsread('length_separate_result.xlsx','1in_4');
in1_uj_6 = xlsread('length_separate_result.xlsx','1in_6');
in1_uj_8 = xlsread('length_separate_result.xlsx','1in_8');
in2_uj_1 = xlsread('length_separate_result.xlsx','2in_1');
in2_uj_2 = xlsread('length_separate_result.xlsx','2in_2');
in3_uj_1 = xlsread('length_separate_result.xlsx','3in_1');

%% finding Ku and Kf value for flame length

x1 = [];
y1 = [];
x2 = [];
y2 = [];
j = 1;
k = 1;
cut_off_value = 0.00775; % most important parameter to choose for flame length result
for i = 1: length(A(:,1))
    if A(i,1)< cut_off_value
        x1(j,1) = A(i,1);
        y1(j,1) = A(i,2);
        j = j+1;
    else 
        x2(k,1) = A(i,1);
        y2(k,1) = A(i,2);
        k = k+1;
    end
end

p1 = polyfit(x1,y1,1);
px1 = 0.002:0.001:0.025;
py1 = polyval(p1,x1);
py1_extend = polyval(p1,px1);

p2 = polyfit(x2,y2,1);
px2 = 0:0.001:0.04;
py2 = polyval(p2,x2);
py2_extend = polyval(p2,px2);


Rsq1 = 1 - sum((y1 - py1).^2)/sum((y1 - mean(y1)).^2);
Rsq2 = 1 - sum((y2 - py2).^2)/sum((y2 - mean(y2)).^2);

figure
plot(x1,y1,'b.')
hold on,
plot(px1,py1_extend,'g')
caption = sprintf('y = %f * x + %f \n R^2 = %f ', p1(1), p1(2),Rsq1);
text(0.02, 0.6, caption, 'FontSize', 12, 'Color', 'g', 'FontWeight', 'bold');


%figure
plot(x2,y2,'b.')
hold on,
plot(px2,py2_extend,'r')
xlabel('Flame shape parameter, X_F = (\rho_j U_j)^(^1^/^2^) d/U_\infty');
ylabel('Normalized flame length, (1/C_f)^(^1^/^2^) L_F/U_\infty');
ylim([0 1.6])
caption = sprintf('y = %f * x + %f \n R^2 = %f', p2(1), p2(2),Rsq2);
text(0.01, 1, caption, 'FontSize', 12, 'Color', 'r', 'FontWeight', 'bold');



%% plotting flame length vs cross flow velocity for different condition
kf1 = p1(1,1);
ku1 = p1(1,2);

kf2 = p2(1,1);
ku2 = p2(1,2);

row = 0.7944;
cf = 0.9782;
d1 = 0.026;
d2 = 0.0526;
d3 = 0.079;

%% Empirical relation for different velocity

kk = 1;
for uj = [1 2 3 4 6 8]
    Lf1 = @(x) kf1*(row*uj)^0.5*cf^0.5*d1 + ku1*x*cf^0.5;
    Lf2 = @(x) kf2*(row*uj)^0.5*cf^0.5*d1 + ku2*x*cf^0.5;

    fg = @(x) Lf1(x) - Lf2(x);
    xint = fzero(fg, 1);
    U_cf_e(:,kk) = [xint;9];
    U_cf_e(:,kk+1) = [1;xint];
    Lf_e(:,kk) = [Lf1(xint);Lf1(9)];
    Lf_e(:,kk+1) = [Lf2(1);Lf2(xint)];
    kk = kk+2;
end


figure
plot(in1_uj_1(:,1),in1_uj_1(:,2),'*b',in1_uj_2(:,1),in1_uj_2(:,2),'*g',in1_uj_3(:,1),in1_uj_3(:,2),'*r',in1_uj_4(:,1),in1_uj_4(:,2),'*c',in1_uj_6(:,1),in1_uj_6(:,2),'*m',in1_uj_8(:,1),in1_uj_8(:,2),'*k',U_cf_e(:,1),Lf_e(:,1),'b-',U_cf_e(:,2),Lf_e(:,2),'b--',U_cf_e(:,3),Lf_e(:,3),'g-',U_cf_e(:,4),Lf_e(:,4),'g--',U_cf_e(:,5),Lf_e(:,5),'r-',U_cf_e(:,6),Lf_e(:,6),'r--',U_cf_e(:,7),Lf_e(:,7),'c-',U_cf_e(:,8),Lf_e(:,8),'c--',U_cf_e(:,9),Lf_e(:,9),'m-',U_cf_e(:,10),Lf_e(:,10),'m--',U_cf_e(:,11),Lf_e(:,11),'k-',U_cf_e(:,12),Lf_e(:,12),'k--');
legend('1inch,U_j = 1m/s','1inch,U_j = 2m/s','1inch,U_j = 3m/s','1inch,U_j = 4m/s','1inch,U_j = 6m/s','1inch,U_j = 8m/s')
xlabel('Crossflow velocity, U_\infty (m/s)');
ylabel('Flame Length, L_F (m)')
title('Flame length vs Cross flow velocity at different flow rate');
set(gca, 'fontsize', 15,'FontName', 'Times');

%% Error estimation 
kk = 1;
for uj = [1 2 3 4 6 8]
    Lf1 = @(x) kf1*(row*uj)^0.5*cf^0.5*d1 + ku1*x*cf^0.5;
    Lf2 = @(x) kf2*(row*uj)^0.5*cf^0.5*d1 + ku2*x*cf^0.5;
    fg = @(x) Lf1(x) - Lf2(x);
    xint = fzero(fg, 1);
    
    name = sprintf('in1_uj_%d',uj);
    val = eval(name);
    
    for ii = 1:length(val(:,1))
        if val(ii,1) < xint
            val(ii,3) = Lf2(val(ii,1));
        else
            val(ii,3) = Lf1(val(ii,1));
        end
    end
    Rsq(kk,1) = 1 - sum((val(:,2) - val(:,3)).^2)/sum((val(:,2) - mean(val(:,2))).^2);
    kk = kk+1;
end
mean_rsq = mean(Rsq)

%% empirical relations for different flow rate

kk = 1;
U_cf_e = [];
Lf_e = [];
for uj = 1
    for d1 = [0.026 0.0526 0.079]
        Lf1 = @(x) kf1*(row*uj)^0.5*cf^0.5*d1 + ku1*x*cf^0.5;
        Lf2 = @(x) kf2*(row*uj)^0.5*cf^0.5*d1 + ku2*x*cf^0.5;

        fg = @(x) Lf1(x) - Lf2(x);
        xint = fzero(fg, 1);
        U_cf_e(:,kk) = [xint;9];
        U_cf_e(:,kk+1) = [1;xint];
        Lf_e(:,kk) = [Lf1(xint);Lf1(9)];
        Lf_e(:,kk+1) = [Lf2(1);Lf2(xint)];
        kk = kk+2;
    end
end

figure
plot(in1_uj_1(:,1),in1_uj_1(:,2),'*b',in2_uj_1(:,1),in2_uj_1(:,2),'*g',in3_uj_1(:,1),in3_uj_1(:,2),'*r',U_cf_e(:,1),Lf_e(:,1),'b-',U_cf_e(:,2),Lf_e(:,2),'b--',U_cf_e(:,3),Lf_e(:,3),'g-',U_cf_e(:,4),Lf_e(:,4),'g--',U_cf_e(:,5),Lf_e(:,5),'r-',U_cf_e(:,6),Lf_e(:,6),'r--')
legend('U_j = 1m/s, d = 0.02664m(~1 inch)','U_j = 1m/s, d = 0.0525m(~2 inch)','U_j = 1m/s, d = 0.079m(~3 inch)')
xlabel('Crossflow velocity, U_\infty (m/s)');
ylabel('Flame Length, L_F (m)')
title('Flame length vs Cross flow velocity at different diameter');
set(gca, 'fontsize', 15,'FontName', 'Times');


%% Error estimation for different diameter
kk = 1;
val = [];
Lf_e = [];
for uj = 1
    for d1 = [0.026 0.0526 0.079]
        Lf1 = @(x) kf1*(row*uj)^0.5*cf^0.5*d1 + ku1*x*cf^0.5;
        Lf2 = @(x) kf2*(row*uj)^0.5*cf^0.5*d1 + ku2*x*cf^0.5;
        fg = @(x) Lf1(x) - Lf2(x);
        xint = fzero(fg, 1);

        if d1 == 0.026
            name = sprintf('in%d_uj_%d',1,uj);
            val = eval(name);
        elseif d1 == 0.0526
            name = sprintf('in%d_uj_%d',2,uj);
            val = eval(name);
        else d1 = 0.079
            name = sprintf('in%d_uj_%d',3,uj);
            val = eval(name);
        end

        for ii = 1:length(val(:,1))
            if val(ii,1) < xint
                val(ii,3) = Lf2(val(ii,1));
            else
                val(ii,3) = Lf1(val(ii,1));
            end
        end
        Rsq_dia(kk,1) = 1 - sum((val(:,2) - val(:,3)).^2)/sum((val(:,2) - mean(val(:,2))).^2);
        kk = kk+1;
    end
end
mean_rsq2 = mean(Rsq_dia)

%% To show empirical equation

row = 0.7944;
cf = 0.9782;
d1 = 0.026;
d2 = 0.0526;
d3 = 0.079;

in1_uj_1(:,3) = ((row*1)^0.5) .* d1./in1_uj_1(:,1);
in1_uj_1(:,4) = (in1_uj_1(:,2)./in1_uj_1(:,1)).*cf^-0.5;

in1_uj_2(:,3) = (row*2)^0.5 * d1./in1_uj_2(:,1);
in1_uj_2(:,4) = in1_uj_2(:,2)./in1_uj_2(:,1).*cf^-0.5;

in1_uj_3(:,3) = (row*3)^0.5 * d1./in1_uj_3(:,1);
in1_uj_3(:,4) = in1_uj_3(:,2)./in1_uj_3(:,1).*cf^-0.5;

in1_uj_4(:,3) = (row*4)^0.5 * d1./in1_uj_4(:,1);
in1_uj_4(:,4) = in1_uj_4(:,2)./in1_uj_4(:,1).*cf^-0.5;

in1_uj_6(:,3) = (row*6)^0.5 * d1./in1_uj_6(:,1);
in1_uj_6(:,4) = in1_uj_6(:,2)./in1_uj_6(:,1).*cf^-0.5;

in1_uj_8(:,3) = (row*8)^0.5 * d1./in1_uj_8(:,1);
in1_uj_8(:,4) = in1_uj_8(:,2)./in1_uj_8(:,1).*cf^-0.5;

in2_uj_1(:,3) = (row*1)^0.5 * d2./in2_uj_1(:,1);
in2_uj_1(:,4) = in2_uj_1(:,2)./in2_uj_1(:,1).*cf^-0.5;

in2_uj_2(:,3) = (row*2)^0.5 * d2./in2_uj_2(:,1);
in2_uj_2(:,4) = in2_uj_2(:,2)./in2_uj_2(:,1).*cf^-0.5;

in3_uj_1(:,3) = (row*1)^0.5 * d3./in3_uj_1(:,1);
in3_uj_1(:,4) = in3_uj_1(:,2)./in3_uj_1(:,1).*cf^-0.5;

figure
plot(in1_uj_1(:,3),in1_uj_1(:,4),'b*',in1_uj_2(:,3),in1_uj_2(:,4),'g*',in1_uj_3(:,3),in1_uj_3(:,4),'r*',in1_uj_4(:,3),in1_uj_4(:,4),'c*',in1_uj_6(:,3),in1_uj_6(:,4),'m*',in1_uj_8(:,3),in1_uj_8(:,4),'k*',in2_uj_1(:,3),in2_uj_1(:,4),'bo',in2_uj_2(:,3),in2_uj_2(:,4),'go',in3_uj_1(:,3),in3_uj_1(:,4),'ro');
%legend('1inch,U_j = 1m/s','1inch,U_j = 2m/s','1inch,U_j = 3m/s','1inch,U_j = 4m/s','1inch,U_j = 6m/s','1inch,U_j = 8m/s','2inch,U_j = 1m/s','2inch,U_j = 2m/s','3inch,U_j = 1m/s')
hold on,
plot(px1,py1_extend,'g')
%legend('Eqn 12');
caption = sprintf('y = %f * x + %f \n R^2 = %f ', p1(1), p1(2),Rsq1);
text(0.01, 1, caption, 'FontSize', 12, 'Color', 'g', 'FontWeight', 'bold');

plot(px2,py2_extend,'r')
legend('1inch,U_j = 1m/s','1inch,U_j = 2m/s','1inch,U_j = 3m/s','1inch,U_j = 4m/s','1inch,U_j = 6m/s','1inch,U_j = 8m/s','2inch,U_j = 1m/s','2inch,U_j = 2m/s','3inch,U_j = 1m/s','Eqn 3.3','Eqn 3.4')
xlabel('Flame shape parameter, X_F = (\rho_j U_j)^(^1^/^2^) d/U_\infty');
ylabel('Normalized flame length, (1/C_f)^(^1^/^2^) L_F/U_\infty');
ylim([0 1.6])
caption = sprintf('y = %f * x + %f \n R^2 = %f', p2(1), p2(2),Rsq2);
text(0.02, 0.6, caption, 'FontSize', 14, 'Color', 'r', 'FontWeight', 'bold');
set(gca, 'fontsize', 15,'FontName', 'Times');