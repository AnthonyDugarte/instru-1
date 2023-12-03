global R1 V pidx ciclos;

%%%%% Críticamente amortiguado:  ζ = 1 %%%%%
%%%%% Críticamente amortiguado:  ζ = 1 %%%%%
%%%%% Críticamente amortiguado:  ζ = 1 %%%%%
%%%%% Críticamente amortiguado:  ζ = 1 %%%%%
%%%%% Críticamente amortiguado:  ζ = 1 %%%%%
%%%%% Críticamente amortiguado:  ζ = 1 %%%%%

dataVCCrit;
dataVLCrit;
dataICCrit;
dataILCrit;

R1 = 925;

V = 5;

iteration_t = 5/(32000*2);
frequency = 1 / (2* iteration_t)

%% VL Block tt1, yy1, ee1

% Initial conditions for the differential equation solver
initialConditions;

% Variables to store the results
tt1 = [];    % Time values
yy1 = [];    % Solution for the circuit's voltage and current
ee1 = [];    % Analytical solution for the circuit's voltage and current

vlTspans =  [ 1 (322-vlOffset ); (324-vlOffset ) (600-vlOffset )]

% Loop for alternating the voltage source and simulating the circuit for 3
% periods (2 iterations per period)
for i = 1:2
    % tspan = [(i - 1) * iteration_t i * iteration_t];
    tspan = VLSUB(vlTspans(i,1):vlTspans(i,2), 1);

    % Solving the differential equations using ode23 function and the edos function
    [t, y] = ode23(@edos, tspan, x0);

    % Analytical solutions for voltage and current of the circuit
    VC_ee = 0.3549511855.*V + 2.076986883.*10^(-11).*(3.3575083.*10^7.*(1434..*vc0 - 509..*V).*cosh(9726.882090.*(t-t(1))) + 10036.19694.*(-2.369924000.*10^11.*il0 - 9.1683746.*10^7.*vc0 + 1.97809921.*10^8.*V).*sinh(9726.882090.*(t-t(1)))).*exp(-333584.9971.*(t-t(1)));
    IL_ee = 0.0006973500697.*V + 2.076986883.*10^(-11).*(3.3575083.*10^7.*(1434..*il0 - 1..*V).*cosh(9726.882090.*(t-t(1))) + 10036.19694.*sinh(9726.882090.*(t-t(1))).*(9.1683746.*10^7.*il0 + 35372..*vc0 - 76491..*V)).*exp(-333584.9971.*(t-t(1)));
    IC_ee = 9.927997299.*10^(-9).*exp(-333584.9971.*(t-t(1))).*(1.00725249.*10^8.*ic0.*cosh(9726.882090.*(t-t(1))) - 10036.19694.*sinh(9726.882090.*(t-t(1))).*(191807..*ic0 + 74..*vl0));
    VL_ee = 9.927997299.*10^(-9).*exp(-333584.9971.*(t-t(1))).*(1.00725249.*10^8.*vl0.*cosh(9726.882090.*(t-t(1))) + 10036.19694.*sinh(9726.882090.*(t-t(1))).*(4.95800000.*10^8.*ic0 + 191807..*vl0));

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

iCTspans =  [ 1 (595-icOff); (596-icOff) (1149-icOff)]

% Loop for alternating the voltage source and simulating the circuit for 3
% periods (2 iterations per period)
for i = 1:2
    % tspan = [(i - 1) * iteration_t i * iteration_t];
    tspan = ICSUB(iCTspans (i,1):iCTspans (i,2), 1);

    % Solving the differential equations using ode23 function and the edos function
    [t, y] = ode23(@edos, tspan, x0);

    % Analytical solutions for voltage and current of the circuit
    VC_ee = 0.3549511855.*V + 2.076986883.*10^(-11).*(3.3575083.*10^7.*(1434..*vc0 - 509..*V).*cosh(9726.882090.*(t-t(1))) + 10036.19694.*(-2.369924000.*10^11.*il0 - 9.1683746.*10^7.*vc0 + 1.97809921.*10^8.*V).*sinh(9726.882090.*(t-t(1)))).*exp(-333584.9971.*(t-t(1)));
    IL_ee = 0.0006973500697.*V + 2.076986883.*10^(-11).*(3.3575083.*10^7.*(1434..*il0 - 1..*V).*cosh(9726.882090.*(t-t(1))) + 10036.19694.*sinh(9726.882090.*(t-t(1))).*(9.1683746.*10^7.*il0 + 35372..*vc0 - 76491..*V)).*exp(-333584.9971.*(t-t(1)));
    IC_ee = 9.927997299.*10^(-9).*exp(-333584.9971.*(t-t(1))).*(1.00725249.*10^8.*ic0.*cosh(9726.882090.*(t-t(1))) - 10036.19694.*sinh(9726.882090.*(t-t(1))).*(191807..*ic0 + 74..*vl0));
    VL_ee = 9.927997299.*10^(-9).*exp(-333584.9971.*(t-t(1))).*(1.00725249.*10^8.*vl0.*cosh(9726.882090.*(t-t(1))) + 10036.19694.*sinh(9726.882090.*(t-t(1))).*(4.95800000.*10^8.*ic0 + 191807..*vl0));

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

iLTspans =  [ 1 (324-ilOffset); (325-ilOffset) (601-ilOffset)]

% Loop for alternating the voltage source and simulating the circuit for 3
% periods (2 iterations per period)
for i = 1:2
    % tspan = [(i - 1) * iteration_t i * iteration_t];
    tspan = ILSUB(iLTspans (i,1):iLTspans (i,2), 1);

    % Solving the differential equations using ode23 function and the edos function
    [t, y] = ode23(@edos, tspan, x0);

    % Analytical solutions for voltage and current of the circuit
    VC_ee = 0.3549511855.*V + 2.076986883.*10^(-11).*(3.3575083.*10^7.*(1434..*vc0 - 509..*V).*cosh(9726.882090.*(t-t(1))) + 10036.19694.*(-2.369924000.*10^11.*il0 - 9.1683746.*10^7.*vc0 + 1.97809921.*10^8.*V).*sinh(9726.882090.*(t-t(1)))).*exp(-333584.9971.*(t-t(1)));
    IL_ee = 0.0006973500697.*V + 2.076986883.*10^(-11).*(3.3575083.*10^7.*(1434..*il0 - 1..*V).*cosh(9726.882090.*(t-t(1))) + 10036.19694.*sinh(9726.882090.*(t-t(1))).*(9.1683746.*10^7.*il0 + 35372..*vc0 - 76491..*V)).*exp(-333584.9971.*(t-t(1)));
    IC_ee = 9.927997299.*10^(-9).*exp(-333584.9971.*(t-t(1))).*(1.00725249.*10^8.*ic0.*cosh(9726.882090.*(t-t(1))) - 10036.19694.*sinh(9726.882090.*(t-t(1))).*(191807..*ic0 + 74..*vl0));
    VL_ee = 9.927997299.*10^(-9).*exp(-333584.9971.*(t-t(1))).*(1.00725249.*10^8.*vl0.*cosh(9726.882090.*(t-t(1))) + 10036.19694.*sinh(9726.882090.*(t-t(1))).*(4.95800000.*10^8.*ic0 + 191807..*vl0));

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
    VC_ee = 0.3549511855.*V + 2.076986883.*10^(-11).*(3.3575083.*10^7.*(1434..*vc0 - 509..*V).*cosh(9726.882090.*(t-t(1))) + 10036.19694.*(-2.369924000.*10^11.*il0 - 9.1683746.*10^7.*vc0 + 1.97809921.*10^8.*V).*sinh(9726.882090.*(t-t(1)))).*exp(-333584.9971.*(t-t(1)));
    IL_ee = 0.0006973500697.*V + 2.076986883.*10^(-11).*(3.3575083.*10^7.*(1434..*il0 - 1..*V).*cosh(9726.882090.*(t-t(1))) + 10036.19694.*sinh(9726.882090.*(t-t(1))).*(9.1683746.*10^7.*il0 + 35372..*vc0 - 76491..*V)).*exp(-333584.9971.*(t-t(1)));
    IC_ee = 9.927997299.*10^(-9).*exp(-333584.9971.*(t-t(1))).*(1.00725249.*10^8.*ic0.*cosh(9726.882090.*(t-t(1))) - 10036.19694.*sinh(9726.882090.*(t-t(1))).*(191807..*ic0 + 74..*vl0));
    VL_ee = 9.927997299.*10^(-9).*exp(-333584.9971.*(t-t(1))).*(1.00725249.*10^8.*vl0.*cosh(9726.882090.*(t-t(1))) + 10036.19694.*sinh(9726.882090.*(t-t(1))).*(4.95800000.*10^8.*ic0 + 191807..*vl0));

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
pidx = 4;
label = 'Critically Damped';
plotingExperimental;