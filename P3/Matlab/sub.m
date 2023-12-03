global R1 V pidx;

%%%%% Subamortiguado: 0 < ζ < 1 %%%%%
%%%%% Subamortiguado: 0 < ζ < 1 %%%%%
%%%%% Subamortiguado: 0 < ζ < 1 %%%%%
%%%%% Subamortiguado: 0 < ζ < 1 %%%%%
%%%%% Subamortiguado: 0 < ζ < 1 %%%%%
%%%%% Subamortiguado: 0 < ζ < 1 %%%%%

dataVCSub;
dataVLSub;
dataICSub;
dataILSub;

R1 = 2000;

%% VL Block tt1, yy1, ee1

V = 5;

iteration_t = 1/(2*9000);
frequency = 1 / (2* iteration_t)

% Initial conditions for the differential equation solver
initialConditions;

% Variables to store the results
tt1 = [];    % Time values
yy1 = [];    % Solution for the circuit's voltage and current
ee1 = [];    % Analytical solution for the circuit's voltage and current

vlTspans =  [ 1 (614-vlOffset ); (615-vlOffset ) (1166-vlOffset )]

% Loop for alternating the voltage source and simulating the circuit for 3
% periods (2 iterations per period)
for i = 1:2
    % tspan = [(i - 1) * iteration_t i * iteration_t];
    tspan = VLSUB(vlTspans(i,1):vlTspans(i,2), 1);

    % Solving the differential equations using ode23 function and the edos function
    [t, y] = ode23(@edos, tspan, x0);

    % Analytical solutions for voltage and current of the circuit
    VC_ee = 0.2028696692.*V + 4.103332311.*10^(-12).*(9.7132071.*10^7.*cos(245163.1943.*(t - t(1))).*(2509..*vc0 - 509..*V) + 9855.560410.*(-6.724120000.*10^10.*il0 - 7.961057.*10^6.*vc0 + 2.8415057.*10^7.*V).*sin(245163.1943.*(t - t(1)))).*exp(-254402.9851.*(t - t(1)));
    IL_ee = 0.0003985651654.*V + 4.103332311.*10^(-12).*(9.7132071.*10^7.*cos(245163.1943.*(t - t(1))).*(2509..*il0 - 1..*V) + 9855.560410.*sin(245163.1943.*(t - t(1))).*(7.961057.*10^6.*il0 + 10036..*vc0 - 5209..*V)).*exp(-254402.9851.*(t - t(1)));
    IC_ee = 1.029526077.*10^(-8).*exp(-254402.9851.*(t - t(1))).*(9.7132071.*10^7.*ic0.*cos(245163.1943.*(t - t(1))) - 9855.560410.*sin(245163.1943.*(t - t(1))).*(3173..*ic0 + 4..*vl0));
    VL_ee = 1.029526077.*10^(-8).*exp(-254402.9851.*(t - t(1))).*(9.7132071.*10^7.*vl0.*cos(245163.1943.*(t - t(1))) + 9855.560410.*sin(245163.1943.*(t - t(1))).*(2.6800000.*10^7.*ic0 + 3173..*vl0));

    % Storing the results in the respective variables
    tt1 = [tt1; t];
    yy1 = [yy1; y];
    ee1 = [ee1; [VC_ee IL_ee IC_ee VL_ee]];

    % Inverting the voltage source for the next iteration
    V = -V;
    % Updating initial conditions for the next iteration

    vc0 = yy1(end, 1);
    il0 = yy1(end, 2);

    loopInitialConditions;
end

data_range1 = vlTspans(1,1):vlTspans(end,2);

%%

%% IC Block tt2, yy2, ee2

V = 5;

initialConditions;

% Variables to store the results
tt2 = [];    % Time values
yy2 = [];    % Solution for the circuit's voltage and current
ee2 = [];    % Analytical solution for the circuit's voltage and current

iCTspans =  [ 1 (610-icOff); (611-icOff) (1163-icOff)]

% Loop for alternating the voltage source and simulating the circuit for 3
% periods (2 iterations per period)
for i = 1:2
    % tspan = [(i - 1) * iteration_t i * iteration_t];
    tspan = ICSUB(iCTspans (i,1):iCTspans (i,2), 1);

    % Solving the differential equations using ode23 function and the edos function
    [t, y] = ode23(@edos, tspan, x0);

    % Analytical solutions for voltage and current of the circuit
    VC_ee = 0.2028696692.*V + 4.103332311.*10^(-12).*(9.7132071.*10^7.*cos(245163.1943.*(t - t(1))).*(2509..*vc0 - 509..*V) + 9855.560410.*(-6.724120000.*10^10.*il0 - 7.961057.*10^6.*vc0 + 2.8415057.*10^7.*V).*sin(245163.1943.*(t - t(1)))).*exp(-254402.9851.*(t - t(1)));
    IL_ee = 0.0003985651654.*V + 4.103332311.*10^(-12).*(9.7132071.*10^7.*cos(245163.1943.*(t - t(1))).*(2509..*il0 - 1..*V) + 9855.560410.*sin(245163.1943.*(t - t(1))).*(7.961057.*10^6.*il0 + 10036..*vc0 - 5209..*V)).*exp(-254402.9851.*(t - t(1)));
    IC_ee = 1.029526077.*10^(-8).*exp(-254402.9851.*(t - t(1))).*(9.7132071.*10^7.*ic0.*cos(245163.1943.*(t - t(1))) - 9855.560410.*sin(245163.1943.*(t - t(1))).*(3173..*ic0 + 4..*vl0));
    VL_ee = 1.029526077.*10^(-8).*exp(-254402.9851.*(t - t(1))).*(9.7132071.*10^7.*vl0.*cos(245163.1943.*(t - t(1))) + 9855.560410.*sin(245163.1943.*(t - t(1))).*(2.6800000.*10^7.*ic0 + 3173..*vl0));

    % Storing the results in the respective variables
    tt2 = [tt2; t];
    yy2 = [yy2; y];
    ee2 = [ee2; [VC_ee IL_ee IC_ee VL_ee]];

    % Inverting the voltage source for the next iteration
    V = -V;
    % Updating initial conditions for the next iteration

    vc0 = yy2(end, 1);
    il0 = yy2(end, 2);

    loopInitialConditions;
end

data_range2 = iCTspans (1,1):iCTspans (end,2);

%%

%% IL Block tt3, yy3, ee3

V = 5;

initialConditions;

% Variables to store the results
tt3 = [];    % Time values
yy3 = [];    % Solution for the circuit's voltage and current
ee3 = [];    % Analytical solution for the circuit's voltage and current

iLTspans =  [ 1 (401-ilOffset); (402-ilOffset) (679-ilOffset)]

% Loop for alternating the voltage source and simulating the circuit for 3
% periods (2 iterations per period)
for i = 1:2
    % tspan = [(i - 1) * iteration_t i * iteration_t];
    tspan = ILSUB(iLTspans (i,1):iLTspans (i,2), 1);

    % Solving the differential equations using ode23 function and the edos function
    [t, y] = ode23(@edos, tspan, x0);

    % Analytical solutions for voltage and current of the circuit
    VC_ee = 0.2028696692.*V + 4.103332311.*10^(-12).*(9.7132071.*10^7.*cos(245163.1943.*(t - t(1))).*(2509..*vc0 - 509..*V) + 9855.560410.*(-6.724120000.*10^10.*il0 - 7.961057.*10^6.*vc0 + 2.8415057.*10^7.*V).*sin(245163.1943.*(t - t(1)))).*exp(-254402.9851.*(t - t(1)));
    IL_ee = 0.0003985651654.*V + 4.103332311.*10^(-12).*(9.7132071.*10^7.*cos(245163.1943.*(t - t(1))).*(2509..*il0 - 1..*V) + 9855.560410.*sin(245163.1943.*(t - t(1))).*(7.961057.*10^6.*il0 + 10036..*vc0 - 5209..*V)).*exp(-254402.9851.*(t - t(1)));
    IC_ee = 1.029526077.*10^(-8).*exp(-254402.9851.*(t - t(1))).*(9.7132071.*10^7.*ic0.*cos(245163.1943.*(t - t(1))) - 9855.560410.*sin(245163.1943.*(t - t(1))).*(3173..*ic0 + 4..*vl0));
    VL_ee = 1.029526077.*10^(-8).*exp(-254402.9851.*(t - t(1))).*(9.7132071.*10^7.*vl0.*cos(245163.1943.*(t - t(1))) + 9855.560410.*sin(245163.1943.*(t - t(1))).*(2.6800000.*10^7.*ic0 + 3173..*vl0));

    % Storing the results in the respective variables
    tt3 = [tt3; t];
    yy3 = [yy3; y];
    ee3 = [ee3; [VC_ee IL_ee IC_ee VL_ee]];

    % Inverting the voltage source for the next iteration
    V = -V;
    % Updating initial conditions for the next iteration

    vc0 = yy3(end, 1);
    il0 = yy3(end, 2);

    loopInitialConditions;
end

data_range3 = iLTspans(1,1):iLTspans (end,2);

%%

%% VC Block tt4, yy4, ee4

V = 5;

initialConditions;

% Variables to store the results
tt4 = [];    % Time values
yy4 = [];    % Solution for the circuit's voltage and current
ee4 = [];    % Analytical solution for the circuit's voltage and current

vCTspans =  [ 1 (607-vcOffset); (608-vcOffset) (1160-vcOffset)]
% vCTspans =  [ 1 (322-43); (323-43) (598-43)]

% Loop for alternating the voltage source and simulating the circuit for 3
% periods (2 iterations per period)
for i = 1:2
    % tspan = [(i - 1) * iteration_t i * iteration_t];
    tspan = VCSUB(vCTspans (i,1):vCTspans (i,2), 1);

    % Solving the differential equations using ode23 function and the edos function
    [t, y] = ode23(@edos, tspan, x0);

    % Analytical solutions for voltage and current of the circuit
    VC_ee = 0.2028696692.*V + 4.103332311.*10^(-12).*(9.7132071.*10^7.*cos(245163.1943.*(t - t(1))).*(2509..*vc0 - 509..*V) + 9855.560410.*(-6.724120000.*10^10.*il0 - 7.961057.*10^6.*vc0 + 2.8415057.*10^7.*V).*sin(245163.1943.*(t - t(1)))).*exp(-254402.9851.*(t - t(1)));
    IL_ee = 0.0003985651654.*V + 4.103332311.*10^(-12).*(9.7132071.*10^7.*cos(245163.1943.*(t - t(1))).*(2509..*il0 - 1..*V) + 9855.560410.*sin(245163.1943.*(t - t(1))).*(7.961057.*10^6.*il0 + 10036..*vc0 - 5209..*V)).*exp(-254402.9851.*(t - t(1)));
    IC_ee = 1.029526077.*10^(-8).*exp(-254402.9851.*(t - t(1))).*(9.7132071.*10^7.*ic0.*cos(245163.1943.*(t - t(1))) - 9855.560410.*sin(245163.1943.*(t - t(1))).*(3173..*ic0 + 4..*vl0));
    VL_ee = 1.029526077.*10^(-8).*exp(-254402.9851.*(t - t(1))).*(9.7132071.*10^7.*vl0.*cos(245163.1943.*(t - t(1))) + 9855.560410.*sin(245163.1943.*(t - t(1))).*(2.6800000.*10^7.*ic0 + 3173..*vl0));

    % Storing the results in the respective variables
    tt4 = [tt4; t];
    yy4 = [yy4; y];
    ee4 = [ee4; [VC_ee IL_ee IC_ee VL_ee]];

    % Inverting the voltage source for the next iteration
    V = -V;
    % Updating initial conditions for the next iteration

    vc0 = yy4(end, 1);
    il0 = yy4(end, 2);

    loopInitialConditions;
end

data_range4 = vCTspans(1,1):vCTspans (end,2);

%%

% Plotting the results for both MATLAB and analytical (MAPLE) solutions
pidx = 0;
label = 'Underdamped';
plotingExperimental;