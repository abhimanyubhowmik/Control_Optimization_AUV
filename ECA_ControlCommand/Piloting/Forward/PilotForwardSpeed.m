function out = PilotForwardSpeed(in, memory, parameters)
% Forward speed control with respect to water with propeller speed actuator

%% Inputs saturations
% u_sat_ms =  EcaF_Saturate(in.u_ms, parameters.u_min_ms, parameters.u_max_ms);
u_sat_ms =  in.u_ms;
uc_sat_ms =  EcaF_Saturate(in.uc_ms, parameters.u_min_ms, parameters.u_max_ms);

%% Compute deltas
delta_u = uc_sat_ms - u_sat_ms;

%% PID controller
N0_rpm = uc_sat_ms/parameters.alpha;
Nc_rpm = N0_rpm + parameters.Kp*delta_u + parameters.Ki*memory.int_u*u_sat_ms;

%% Output saturation
out.Nc_rpm = EcaF_Saturate(Nc_rpm,parameters.N_sat_rpm(1),parameters.N_sat_rpm(2));

end