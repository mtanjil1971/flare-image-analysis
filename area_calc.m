figure
yyaxis left
plot(a(1:5,2),a(1:5,3),'*r',a(6:10,2),a(6:10,3),'+g',a(11:15,2),a(11:15,3),'*b',a(16:20,2),a(16:20,3),'*y');
xlabel('cross flow velocity, U_c_f (m/s)');
ylabel('Whole flame area from side, (cm^2)');
legend('uj = 2m/s','uj = 4m/s','uj = 6m/s','uj = 8m/s');
yyaxis right
plot(a(1:5,2),a(1:5,4),'*r',a(6:10,2),a(6:10,4),'+g',a(11:15,2),a(11:15,4),'*b',a(16:20,2),a(16:20,4),'*y');
ylabel('partical flame area from top, (cm^2)');
