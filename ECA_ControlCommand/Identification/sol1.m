%close all; clear;
%addpath

% load data
load('Data/SpeedSteps_Noise_U.mat');

% load physical parameters
auv_param = loadjson('Conf/AUVParameters.json');

% Data
u = vehicle_state.nu.rAUV_WaterSpeed.Uwater_ms.Data;

figure;
plot(vehicle_state.nu.rAUV_WaterSpeed.Uwater_ms.Time,...
    vehicle_state.nu.rAUV_WaterSpeed.Uwater_ms.Data)

grid on; ylabel('speed (m/s)'); xlabel('Time (s)');
title('U');
Fx = forces_values.HydrodynamicForces.Fx_N.Data(:);

% Parameters
rho = auv_param.Environment.Rho;
nu = auv_param.Environment.nu;
Lref = auv_param.Mecanic.length_reference;
Sref = auv_param.Mecanic.surface_reference;

CXf = 0.075./(log10(u*Lref/nu)-2).^2;
%ksh = 1;

ksh = lsqr(0.5*rho*Sref*CXf.*u.*abs(u), Fx);

figure; grid on; hold on;
plot(Fx);
plot(0.5*rho*Sref* ksh * CXf.*u.*abs(u));
legend('data', 'fit');
