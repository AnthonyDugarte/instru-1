% Clearing the workspace, command window, and closing any open figures
% clc
% clear all
% close all

% Defining circuit parameters as global variables
global R1 R2 R3 C V;

% Circuit component values
R1 = 1235 + 50;      % Resistance (Ohms)
R2 = 803.1;       % Resistance (Ohms)
R3 = 1075;      % Resistance (Ohms)
C = 1E-6;       % Capacitance (Farads)
V = 5;          % Voltage source value (Volts)

% Time constant of the circuit
tao = C * ((R2 + R3) * R1 + R2 * R3) / (R1 + R3)

% iteration_t = 5 * tao * 1.5;
iteration_t = 0.01044059303;
frequency = 1 / (2* iteration_t)
% iteration_t = 0.00731;

% Initial conditions for the differential equation solver
v0 = R3*(-V)/((R1*R2 + R1*R3 + R2*R3)*(-R1*R3/((R1*R2 + R1*R3 + R2*R3)*R2) + 1/R2));
x0 = [v0; (R1 * R3 / ((R1 * R2 + R1 * R3 + R2 * R3) * R2) - 1 / R2) * v0 +  R3 * V / (R1 * R2 + R1 * R3 + R2 * R3)];

v0m = v0
x0m = x0

% Variables to store the results
tt = [];    % Time values
yy = [];    % Solution for the circuit's voltage and current
ee = [];    % Analytical solution for the circuit's voltage and current

tspans =  [ 1 519; 520 1043]
    % 541:1062,;

% Loop for alternating the voltage source and simulating the circuit for 3
% periods (2 iterations per period)
for i = 1:length(tspans)
    % tspan = [(i - 1) * iteration_t i * iteration_t];
    tspan = F0001CH1(tspans(i,1):tspans(i,2), 1);

    % Solving the differential equations using ode23 function and the edos function
    [t, y] = ode23(@edos, tspan, x0);

    % Analytical solutions for voltage and current of the circuit
    VL_ee = R3 * V / (R1 + R3) + exp(-(R1 + R3) * (t - t(1)) / ((R1 * R2 + R1 * R3 + R2 * R3) * C)) * (v0m * (R1 + R3) - R3 * V) / (R1 + R3);
    IL_ee = exp(-(R1 + R3) * (t - t(1)) / (C * ((R2 + R3) * R1 + R2 * R3))) * ((-R1 - R3) * v0m + R3 * V) / ((R1 + R2) * R3 + R1 * R2);

    % Storing the results in the respective variables
    tt = [tt; t];
    yy = [yy; y];
    ee = [ee; [VL_ee IL_ee]];

    % Inverting the voltage source for the next iteration
    V = -V;
    % Updating initial conditions for the next iteration
    v0 = yy(end, 1);
    x0 = [v0; (R1 * R3 / ((R1 * R2 + R1 * R3 + R2 * R3) * R2) - 1 / R2) * v0 + R3 * V / (R1 * R2 + R1 * R3 + R2 * R3)];

    v0m = ee(end, 1);
    x0m = [v0m; (R1 * R3 / ((R1 * R2 + R1 * R3 + R2 * R3) * R2) - 1 / R2) * v0m + R3 * V / (R1 * R2 + R1 * R3 + R2 * R3)];
end

% Plotting the results for voltage (Vl) and current (Il) for both MATLAB and analytical (MAPLE) solutions
figure(1)

data_range = tspans(1,1):tspans(end,2);

plot(tt, yy(:, 1), tt, ee(:, 1),F0001CH1(data_range ,1),F0001CH1(data_range ,2))
xlabel('Time t');
ylabel('Solution Vl');
legend('MATLAB', 'MAPLE', 'Experimental');
 
figure(2)
plot(tt, yy(:, 2), tt, ee(:, 2),F0001CH2(data_range ,1),F0001CH2(data_range ,2))
xlabel('Time t');
ylabel('Solution Il');
legend('MATLAB', 'MAPLE', 'Experimental');

errorVC = mae(ee(:,1),F0001CH1(tspans,2));
errorIC = mae(ee(:,2),F0001CH2(tspans,2));