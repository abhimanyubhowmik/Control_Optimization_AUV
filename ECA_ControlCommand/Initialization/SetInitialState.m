function [initial_state,initial_actuators] = SetInitialState()
% Set the initial vehicle status settings in the simulator
%
% :usage: [initial_state,initial_actuators] = SetInitialState()
%
% :returns:
%   * initial_state - initial vehicle status settings in the simulator
%   * initial_actuators - initial actuators status settings in the simulator

initial_state.nu.rAUV_WaterSpeed.Uwater_ms = 2.5;
initial_state.nu.rAUV_WaterSpeed.Vwater_ms = 0;
initial_state.nu.rAUV_WaterSpeed.Wwater_ms = 0;

initial_state.nu.AngularSpeed.P_rads = 0;
initial_state.nu.AngularSpeed.Q_rads = 0;
initial_state.nu.AngularSpeed.R_rads = 0;

initial_state.eta.rABS_Position.x_m = 0;
initial_state.eta.rABS_Position.y_m = 0;
initial_state.eta.rABS_Position.z_m = 40;

initial_state.eta.EulerAngles.Phi_rad = 0;
initial_state.eta.EulerAngles.Theta_rad = 0;
initial_state.eta.EulerAngles.Psi_rad = 0;

initial_actuators.physical_helms.B1_rad = 0;
initial_actuators.physical_helms.B2_rad = 0;
initial_actuators.physical_helms.B3_rad = 0;
initial_actuators.physical_helms.B4_rad = 0;
initial_actuators.virtual_helms.A_rad = 0;
initial_actuators.virtual_helms.BAR_rad = 0;
initial_actuators.virtual_helms.G_rad = 0;
initial_actuators.N_rpm = 550;
end