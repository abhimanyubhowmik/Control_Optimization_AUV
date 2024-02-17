%close all; clear;

% Load data
load('Data/DieuDonne_AStep_NoiseOn_U_V_R_A.mat');

% Load physical parameters
auv_param = loadjson('Conf/AUVParameters.json');

% Data
v = vehicle_state.nu.rAUV_WaterSpeed.Vwater_ms.Data;
u = vehicle_state.nu.rAUV_WaterSpeed.Uwater_ms.Data;
r = vehicle_state.nu.AngularSpeed.R_rads.Data;

% Load force and moment
Fy = forces_values.HydrodynamicForces.Fy_N.Data(:);
Mz = forces_values.HydrodynamicForces.Mz_Nm.Data(:);


% Parameters
rho = auv_param.Environment.Rho;
Lref = auv_param.Mecanic.length_reference;
Sref = auv_param.Mecanic.surface_reference;
CZ0 = auv_param.Hydrodynamic.CZ0;
CM0 = auv_param.Hydrodynamic.CM0;

%CZuw = -3.15817126288066;
%CZuq = -1.939351431208791;


% Calculate parameters for the force
% Fy = 0.5 * rho * Sref * (CYuv .* v .* u + Lref * CYur .* r .* u)
fun = @(C_vect) sum((Fy - 0.5 * rho * Sref  .* (C_vect(1) .* v .* u + Lref * C_vect(2) .* r .* u)).^ 2);
x0 = [CZuw,-CZuq];
lower_bound = [(1.2 * CZuw) (0.975 * (-CZuq))];
upper_bound = [(0.8 * CZuw) (1.025 * (-CZuq))];


C_vect = fminsearchbnd(fun, x0, lower_bound, upper_bound);

CYuv = C_vect(1)
CYur = C_vect(2)

% Check calculated parameters
figure; grid on; hold on;
plot(Fy);
% Here we plot whole Fy expression
plot(0.5 * rho * Sref * (CYuv .* v .* u + Lref * CYur .* r .* u));
legend('data', 'fit');



%CMuw = 0.978235318365837;
%CMuq = -0.890840404845499;

% Calculate parameters for the moment
% Mz = 0.5 * rho * Sref * (CNuv .* v .* u + Lref^2 * CNur .* r .* u)
fun = @(C_vect) sum((Mz - 0.5 * rho * Sref * (C_vect(1) .* v .* u + Lref^2 * C_vect(2) .* r .* u)).^ 2);
x0 = [CZuw,-CZuq];
lower_bound = [(1.1 * (-CMuw)) (1.1 * CMuq)];
upper_bound = [(0.9 * (-CMuw)) (0.9 * CMuq)];


C_vect = fminsearchbnd(fun, x0, lower_bound, upper_bound);

CNuv = C_vect(1)
CNur = C_vect(2)

% Check calculated parameters
figure; grid on; hold on;
plot(Mz);
% Here we plot whole Fy expression
plot(0.5 * rho * Sref * (CNuv .* v .* u + Lref^2 * CNur .* r .* u));
legend('data', 'fit');