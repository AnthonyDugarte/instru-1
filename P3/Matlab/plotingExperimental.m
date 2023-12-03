global pidx label;

% VL tt1 4
% IC tt2 3
% IL tt3 2
% VC tt4 1

% Plotting the results for voltage (Vl) and current (Il) for both MATLAB and analytical (MAPLE) solutions
figure(pidx + 1)
plot(tt4, yy4(:, 1), tt4, ee4(:, 1),VCSUB(data_range4,1), VCSUB(data_range4,2))
xlabel('Time t');
ylabel(strcat('VC(t) ', label));
legend('MATLAB', 'MAPLE');
grid minor

figure(pidx + 2)
plot(tt3, yy3(:, 2), tt3, ee3(:, 2),ILSUB(data_range3,1), ILSUB(data_range3,2))
xlabel('Time t');
ylabel(strcat('IL(t) ', label));
legend('MATLAB', 'MAPLE');
grid minor

figure(pidx + 3)
plot(tt2, yy2(:, 3), tt2, ee2(:, 3),ICSUB(data_range2,1), ICSUB(data_range2,2))
% plot(tt2, yy2(:, 3), tt2, ee2(:, 3))
xlabel('Time t');
ylabel(strcat('IC(t) ', label));
legend('MATLAB', 'MAPLE');
grid minor
 
figure(pidx + 4)
plot(tt1, yy1(:, 4), tt1, ee1(:, 4),VLSUB(data_range1 ,1),VLSUB(data_range1 ,2))
xlabel('Time t');
ylabel(strcat('VL(t) ', label));
legend('MATLAB', 'MAPLE');
grid minor