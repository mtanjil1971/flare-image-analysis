clc, close all,
A = load('1_inch_width_calculation_result.mat');
A.A{1,11} = 'trajectory';
for row = 2:76
    traj1 = A.A{row,3} + (A.A{row,2} - A.A{row,3})/2;
    traj2 = traj1(167:end);
    traj3 = traj2 - traj2(1,1);
    traj4 = traj3*(-1);
    y = (0:0.06096:(length(traj4(:,1))-1)*0.06096)';
    x = traj4;
    traject(:,1) = x;
    traject(:,2) = y;
    A.A{row,11} = traject(:,:);
    traject = [];
end
save('1_inch_trajectory_result.mat', 'A');
