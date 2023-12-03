% Clearing the workspace, command window, and closing any open figures
clc
clear all
close all

% Defining circuit parameters as global variables
global R1 R2 R3 C L V pidx ciclos;

% global Circuit component values
R2 = 500 + 9;       % Resistance (Ohms)
R3 = 1000;      % Resistance (Ohms)
C = 1E-9;       % Capacitance (Farads)
L = 6.7E-3;          % Inductance (Henry)

V = 5;

ciclos = 6;

% Each behavior have their own script
sub;
critico;
sobre;