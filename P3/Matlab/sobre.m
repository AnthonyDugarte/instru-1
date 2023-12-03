global R1 V pidx ciclos;

%%%%% Sobreamortiguado: ζ > 1 %%%%%
%%%%% Sobreamortiguado: ζ > 1 %%%%%
%%%%% Sobreamortiguado: ζ > 1 %%%%%
%%%%% Sobreamortiguado: ζ > 1 %%%%%
%%%%% Sobreamortiguado: ζ > 1 %%%%%
%%%%% Sobreamortiguado: ζ > 1 %%%%%

R1 = 700;

dataVCSobre;
dataVLSobre;
dataICSobre;
dataILSobre;

iteration_t = 8 * 5/(3.961940298 * 10^5);
frequency = 1 / (2* iteration_t)

%% VL Block tt1, yy1, ee1

% Initial conditions for the differential equation solver
initialConditions;

% Variables to store the results
tt1 = [];    % Time values
yy1 = [];    % Solution for the circuit's voltage and current
ee1 = [];    % Analytical solution for the circuit's voltage and current

vlTspans =  [ 1 (301-vlOffset ); (302-vlOffset ) (578-vlOffset )]

% Loop for alternating the voltage source and simulating the circuit for 3
% periods (2 iterations per period)
for i = 1:2
    % tspan = [(i - 1) * iteration_t i * iteration_t];
    tspan = VLSUB(vlTspans(i,1):vlTspans(i,2), 1);

    % Solving the differential equations using ode23 function and the edos function
    [t, y] = ode23(@edos, tspan, x0);

    % Analytical solutions for voltage and current of the circuit
    VC_ee = 0.4210090984.*V + 1.875132290.*10^(-12).*(4.41104803.*10^8.*(1209..*vc0 - 509..*V).*cosh(159690.0295.*(t-t(1))) + 36377.38871.*(-3.780140000.*10^10.*il0 - 2.0692841.*10^7.*vc0 + 3.9978541.*10^7.*V).*sinh(159690.0295.*(t-t(1)))).*exp(-362831.4311.*(t-t(1)));
    IL_ee = 0.0008271298594.*V + 1.875132290.*10^(-12).*(4.41104803.*10^8.*(1209..*il0 - 1..*V).*cosh(159690.0295.*(t-t(1))) + 36377.38871.*sinh(159690.0295.*(t-t(1))).*(2.0692841.*10^7.*il0 + 5642..*vc0 - 19491..*V)).*exp(-362831.4311.*(t-t(1)));
    IC_ee = 7.556783129.*10^(-10).*exp(-362831.4311.*(t-t(1))).*(1.323314409.*10^9.*ic0.*cosh(159690.0295.*(t-t(1))) - 36377.38871.*sinh(159690.0295.*(t-t(1))).*(51347..*ic0 + 14..*vl0));
    VL_ee = 7.556783129.*10^(-10).*exp(-362831.4311.*(t-t(1))).*(1.323314409.*10^9.*vl0.*cosh(159690.0295.*(t-t(1))) + 36377.38871.*sinh(159690.0295.*(t-t(1))).*(9.3800000.*10^7.*ic0 + 51347..*vl0));

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

iCTspans =  [ 1 (321-icOff); (322-icOff) (578-icOff)]

% Loop for alternating the voltage source and simulating the circuit for 3
% periods (2 iterations per period)
for i = 1:2
    % tspan = [(i - 1) * iteration_t i * iteration_t];
    tspan = ICSUB(iCTspans (i,1):iCTspans (i,2), 1);

    % Solving the differential equations using ode23 function and the edos function
    [t, y] = ode23(@edos, tspan, x0);

    % Analytical solutions for voltage and current of the circuit
    VC_ee = 0.4210090984.*V + 1.875132290.*10^(-12).*(4.41104803.*10^8.*(1209..*vc0 - 509..*V).*cosh(159690.0295.*(t-t(1))) + 36377.38871.*(-3.780140000.*10^10.*il0 - 2.0692841.*10^7.*vc0 + 3.9978541.*10^7.*V).*sinh(159690.0295.*(t-t(1)))).*exp(-362831.4311.*(t-t(1)));
    IL_ee = 0.0008271298594.*V + 1.875132290.*10^(-12).*(4.41104803.*10^8.*(1209..*il0 - 1..*V).*cosh(159690.0295.*(t-t(1))) + 36377.38871.*sinh(159690.0295.*(t-t(1))).*(2.0692841.*10^7.*il0 + 5642..*vc0 - 19491..*V)).*exp(-362831.4311.*(t-t(1)));
    IC_ee = 7.556783129.*10^(-10).*exp(-362831.4311.*(t-t(1))).*(1.323314409.*10^9.*ic0.*cosh(159690.0295.*(t-t(1))) - 36377.38871.*sinh(159690.0295.*(t-t(1))).*(51347..*ic0 + 14..*vl0));
    VL_ee = 7.556783129.*10^(-10).*exp(-362831.4311.*(t-t(1))).*(1.323314409.*10^9.*vl0.*cosh(159690.0295.*(t-t(1))) + 36377.38871.*sinh(159690.0295.*(t-t(1))).*(9.3800000.*10^7.*ic0 + 51347..*vl0));

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

iLTspans =  [ 1 (339-ilOffset); (340-ilOffset) (617-ilOffset)]

% Loop for alternating the voltage source and simulating the circuit for 3
% periods (2 iterations per period)
for i = 1:2
    % tspan = [(i - 1) * iteration_t i * iteration_t];
    tspan = ILSUB(iLTspans (i,1):iLTspans (i,2), 1);

    % Solving the differential equations using ode23 function and the edos function
    [t, y] = ode23(@edos, tspan, x0);

    % Analytical solutions for voltage and current of the circuit
    VC_ee = 0.4210090984.*V + 1.875132290.*10^(-12).*(4.41104803.*10^8.*(1209..*vc0 - 509..*V).*cosh(159690.0295.*(t-t(1))) + 36377.38871.*(-3.780140000.*10^10.*il0 - 2.0692841.*10^7.*vc0 + 3.9978541.*10^7.*V).*sinh(159690.0295.*(t-t(1)))).*exp(-362831.4311.*(t-t(1)));
    IL_ee = 0.0008271298594.*V + 1.875132290.*10^(-12).*(4.41104803.*10^8.*(1209..*il0 - 1..*V).*cosh(159690.0295.*(t-t(1))) + 36377.38871.*sinh(159690.0295.*(t-t(1))).*(2.0692841.*10^7.*il0 + 5642..*vc0 - 19491..*V)).*exp(-362831.4311.*(t-t(1)));
    IC_ee = 7.556783129.*10^(-10).*exp(-362831.4311.*(t-t(1))).*(1.323314409.*10^9.*ic0.*cosh(159690.0295.*(t-t(1))) - 36377.38871.*sinh(159690.0295.*(t-t(1))).*(51347..*ic0 + 14..*vl0));
    VL_ee = 7.556783129.*10^(-10).*exp(-362831.4311.*(t-t(1))).*(1.323314409.*10^9.*vl0.*cosh(159690.0295.*(t-t(1))) + 36377.38871.*sinh(159690.0295.*(t-t(1))).*(9.3800000.*10^7.*ic0 + 51347..*vl0));

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

vCTspans =  [ 1 (307-vcOffset); (308-vcOffset) (585-vcOffset)]
% vCTspans =  [ 1 (322-43); (323-43) (598-43)]

% Loop for alternating the voltage source and simulating the circuit for 3
% periods (2 iterations per period)
for i = 1:2
    % tspan = [(i - 1) * iteration_t i * iteration_t];
    tspan = VCSUB(vCTspans (i,1):vCTspans (i,2), 1);

    % Solving the differential equations using ode23 function and the edos function
    [t, y] = ode23(@edos, tspan, x0);

    % Analytical solutions for voltage and current of the circuit
    VC_ee = 0.4210090984.*V + 1.875132290.*10^(-12).*(4.41104803.*10^8.*(1209..*vc0 - 509..*V).*cosh(159690.0295.*(t-t(1))) + 36377.38871.*(-3.780140000.*10^10.*il0 - 2.0692841.*10^7.*vc0 + 3.9978541.*10^7.*V).*sinh(159690.0295.*(t-t(1)))).*exp(-362831.4311.*(t-t(1)));
    IL_ee = 0.0008271298594.*V + 1.875132290.*10^(-12).*(4.41104803.*10^8.*(1209..*il0 - 1..*V).*cosh(159690.0295.*(t-t(1))) + 36377.38871.*sinh(159690.0295.*(t-t(1))).*(2.0692841.*10^7.*il0 + 5642..*vc0 - 19491..*V)).*exp(-362831.4311.*(t-t(1)));
    IC_ee = 7.556783129.*10^(-10).*exp(-362831.4311.*(t-t(1))).*(1.323314409.*10^9.*ic0.*cosh(159690.0295.*(t-t(1))) - 36377.38871.*sinh(159690.0295.*(t-t(1))).*(51347..*ic0 + 14..*vl0));
    VL_ee = 7.556783129.*10^(-10).*exp(-362831.4311.*(t-t(1))).*(1.323314409.*10^9.*vl0.*cosh(159690.0295.*(t-t(1))) + 36377.38871.*sinh(159690.0295.*(t-t(1))).*(9.3800000.*10^7.*ic0 + 51347..*vl0));

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
pidx = 8;
label = 'Overdamped';
plotingExperimental;