global tt yy ee pidx label;

% Plotting the results for voltage (Vl) and current (Il) for both MATLAB and analytical (MAPLE) solutions
figure(pidx + 1)
plot(tt1, yy1(:, 1), tt1, ee1(:, 1))
xlabel('Time t');
ylabel(strcat('VC(t) ', label));
legend('MATLAB', 'MAPLE');
grid minor

figure(pidx + 2)
plot(tt1, yy1(:, 2), tt1, ee1(:, 2))
xlabel('Time t');
ylabel(strcat('IL(t) ', label));
legend('MATLAB', 'MAPLE');
grid minor

figure(pidx + 3)
plot(tt1, yy1(:, 3), tt1, ee1(:, 3))
xlabel('Time t');
ylabel(strcat('IC(t) ', label));
legend('MATLAB', 'MAPLE');
grid minor
 
figure(pidx + 4)
plot(tt1, yy1(:, 4), tt1, ee1(:, 4))
xlabel('Time t');
ylabel(strcat('VL(t) ', label));
legend('MATLAB', 'MAPLE');
grid minor