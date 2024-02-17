%close all; clear;
%addpath

% Load data
load('Data/PitchSteps_NoiseOn_Pitch_W_Q.mat');

% Load physical parameters
auv_param = loadjson('Conf/AUVParameters.json');

% Data
u = vehicle_state.nu.rAUV_WaterSpeed.Uwater_ms.Data;
w = vehicle_state.nu.rAUV_WaterSpeed.Wwater_ms.Data;
q = vehicle_state.nu.AngularSpeed.Q_rads.Data;

% Load force and moment
Fz = forces_values.HydrodynamicForces.Fz_N.Data(:);
My = forces_values.HydrodynamicForces.My_Nm.Data(:);

% Parameters
rho = auv_param.Environment.Rho;
Lref = auv_param.Mecanic.length_reference;
Sref = auv_param.Mecanic.surface_reference;
CZ0 = auv_param.Hydrodynamic.CZ0;
CM0 = auv_param.Hydrodynamic.CM0;

% Calculate parameters for the force
% Fz = 0.5 * rho * Sref * (CZ0 .* u .* abs(u) + CZuw .* u .* w + Lref * CZuq .* u .* q)
% Fz - 0.5 * rho * Sref * CZ0 .* u .* abs(u) = 0.5 * rho * Sref .* u .* [CZuw, CZuq] * [w, Lref .* q]
C_vect = lsqr(0.5 * rho * Sref .* u .* [w, Lref .* q], Fz - 0.5 * rho * Sref * CZ0 .* u .* abs(u));
CZuw = C_vect(1)
CZuq = C_vect(2)

% Check calculated parameters
figure; grid on; hold on;
plot(Fz);
% Here we plot whole Fz expression
plot(0.5 * rho * Sref * (CZ0 .* u .* abs(u) + CZuw .* u .* w + Lref * CZuq .* u .* q));
legend('data', 'fit');


% Most common value of CM0, the value in the JSON object in synthetic
CM0 = 0;
% Calculate parameters for the moment
% My = 0.5 * rho * Sref * Lref * (CM0 .* u .* abs(u) + CMuw .* u .* w + Lref * CMuq .* u .* q)
% My - 0.5 * rho * Sref * Lref *CM0 .* u .* abs(u) = 0.5 * rho * Sref * Lref .* u .* [CMuw, CMuq] * [w, Lref .* q]
C_vect = lsqr(0.5 * rho * Sref * Lref .* u .* [w, Lref .* q], My - 0.5 * rho * Sref * Lref * CM0 .* u .* abs(u));
CMuw = C_vect(1)
CMuq = C_vect(2)

% Check calculated parameters
figure; grid on; hold on;
plot(My);
% Here we plot whole My expression
plot(0.5 * rho * Sref * Lref *(0 .* u .* abs(u) + CMuw .* u .* w + Lref * CMuq .* u .* q));
legend('data', 'fit');