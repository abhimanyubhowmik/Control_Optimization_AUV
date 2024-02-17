%% Plots the results of the simulation
warning off; % Warning off because some legend are "extra"
% Notes :
%   - all subplot in the same figure are link on x axis
%% Vehicle State : Depth
figure('Name','Depth profil','units','normalized','outerposition',[0 0 1 1]); hold on;
h1 = area(vehicle_state.eta.rABS_Position.z_m.Time,...
    [inputs.seabed_m.Data,ones(length(inputs.seabed_m.Data),1)*5]);

h2 = area(inputs.seabed_m.Time, inputs.seabed_m.Data);
set(h2,'FaceColor',[0 0.85 0.85]); % sea
set(h1,'FaceColor',[0 0.25 0.25]); % ground

p1 = plot(vehicle_state.eta.rABS_Position.z_m,'y','LineWidth',2);
z_cmd = CreateCmd(inputs.command.vertical, inputs.Flag.FlagVertical, 1);
if ~isempty(z_cmd.Data)
    p2 = plot(z_cmd,'b','LineWidth',2);
else
    p2 = [];
end
axis tight; xlabel('DateTime'); ylabel('Depth (m)');
title('Depth profil');  set(gca,'Ydir','reverse');
legend([p1 p2],'depth', 'depth_{command}'); clear h1 h2 p1 p2 z_cmd

%% Vehicle State : XY Plot
figure('Name','XY Plot','units','normalized','outerposition',[0 0 1 1]);
plot(vehicle_state.eta.rABS_Position.y_m.Data,...
    vehicle_state.eta.rABS_Position.x_m.Data); grid on;
title('XY Plot');xlabel('East (m)'); ylabel('North (m)');

%% Vehicle State : Angles
figure('name','Euler angles','units','normalized','outerposition',[0 0 1 1]);
s1 = subplot(3,1,1); hold on; grid on;
plot(vehicle_state.eta.EulerAngles.Phi_rad.Time,rad2deg(vehicle_state.eta.EulerAngles.Phi_rad.Data));
roll_cmd = CreateCmd(inputs.command.roll, inputs.Flag.FlagRoll, 1);
stairs(roll_cmd.Time, rad2deg(roll_cmd.Data)); clear roll_cmd;
legend('\phi','\phi_{command}');
title('Roll');xlabel('time (s)'); ylabel('Angle (deg)');

s2 = subplot(3,1,2); hold on; grid on;
plot(vehicle_state.eta.EulerAngles.Theta_rad.Time,rad2deg(vehicle_state.eta.EulerAngles.Theta_rad.Data));
theta_cmd = CreateCmd(inputs.command.vertical, inputs.Flag.FlagVertical, 2);
stairs(theta_cmd.Time, rad2deg(theta_cmd.Data)); clear theta_cmd;
legend('\theta','\theta_{command}');
title('Theta');xlabel('time (s)'); ylabel('Angle (deg)');

s3 = subplot(3,1,3); hold on; grid on;
plot(vehicle_state.eta.EulerAngles.Psi_rad.Time,rad2deg(vehicle_state.eta.EulerAngles.Psi_rad.Data));
psi_cmd = CreateCmd(inputs.command.horizontal, inputs.Flag.FlagHorizontal, 1);
stairs(psi_cmd.Time, rad2deg(psi_cmd.Data)); clear psi_cmd;
legend('\psi','\psi_{command}');
title('Psi');xlabel('time (s)'); ylabel('Angle (deg)');

linkaxes([s1 s2 s3],'x'); clear s1 s2 s3;
%% Vehicle State : Speed
figure('name','Speed','units','normalized','outerposition',[0 0 1 1]);
s1 = subplot(3,1,1); hold on; grid on;
plot(vehicle_state.nu.rAUV_WaterSpeed.Uwater_ms);
u_cmd = CreateCmd(inputs.command.speed, inputs.Flag.FlagForward, 1);
plot(u_cmd); clear u_cmd;
legend('u','u_{command}');
title('Longitudinal Speed');xlabel('time (s)'); ylabel('Speed (m.s^{-1})');

s2 = subplot(3,1,2); hold on; grid on;
plot(vehicle_state.nu.rAUV_WaterSpeed.Vwater_ms);
title('Transversal Speed');xlabel('time (s)'); ylabel('Speed (m.s^{-1})');

s3 = subplot(3,1,3); hold on; grid on;
plot(vehicle_state.nu.rAUV_WaterSpeed.Wwater_ms);
title('Lift Speed');xlabel('time (s)'); ylabel('Speed (m.s^{-1})');

linkaxes([s1 s2 s3],'x'); clear s1 s2 s3;
%% Vehicle State : AngularSpeed
figure('name','Angular Speed','units','normalized','outerposition',[0 0 1 1]);
s1 = subplot(3,1,1); hold on; grid on;
plot(vehicle_state.nu.AngularSpeed.P_rads.Time, ...
    rad2deg(vehicle_state.nu.AngularSpeed.P_rads.Data));
title('Roll Rate');xlabel('time (s)'); ylabel('Angular Speed (deg.s^{-1})');

s2 = subplot(3,1,2); hold on; grid on;
plot(vehicle_state.nu.AngularSpeed.Q_rads.Time,...
    rad2deg(vehicle_state.nu.AngularSpeed.Q_rads.Data));
title('Pitch Rate');xlabel('time (s)'); ylabel('Angular Speed (deg.s^{-1})');

s3 = subplot(3,1,3); hold on; grid on;
plot(vehicle_state.nu.AngularSpeed.R_rads.Time,...
    rad2deg(vehicle_state.nu.AngularSpeed.R_rads.Data));
r_cmd = CreateCmd(inputs.command.horizontal, inputs.Flag.FlagHorizontal, 2);
stairs(r_cmd.Time, rad2deg(r_cmd.Data)); clear r_cmd;
legend('R','R_{command}');
title('Yaw Rate');xlabel('time (s)'); ylabel('Angular Speed (deg.s^{-1})');

linkaxes([s1 s2 s3],'x'); clear s1 s2 s3;
%% Actuators
figure('name','actuators','units','normalized','outerposition',[0 0 1 1]);
s1 = subplot(4,1,1); hold on; grid on;
plot(actuator_values.virtual_helms.BAR_rad.Time,rad2deg(actuator_values.virtual_helms.BAR_rad.Data));
bar_cmd = CreateCmd(inputs.command.vertical, inputs.Flag.FlagVertical, 0);
stairs(bar_cmd.Time, rad2deg(bar_cmd.Data)); clear bar_cmd;
legend('BAR_c','BAR_{OL command}');
title('BAR');xlabel('time (s)'); ylabel('Angle (°)');

s2 = subplot(4,1,2); hold on; grid on;
plot(actuator_values.virtual_helms.A_rad.Time,rad2deg(actuator_values.virtual_helms.A_rad.Data));
a_cmd = CreateCmd(inputs.command.horizontal, inputs.Flag.FlagHorizontal, 0);
stairs(a_cmd.Time, rad2deg(a_cmd.Data)); clear a_cmd;
legend('A_c','A_{OL command}');
title('A');xlabel('time (s)'); ylabel('Angle (°)');

s3 = subplot(4,1,3); hold on; grid on;
plot(actuator_values.virtual_helms.G_rad.Time,rad2deg(actuator_values.virtual_helms.G_rad.Data));
g_cmd = CreateCmd(inputs.command.roll, inputs.Flag.FlagRoll, 0);
stairs(g_cmd.Time, rad2deg(g_cmd.Data)); clear g_cmd;
legend('G_c','G_{OL command}');
title('G');xlabel('time (s)'); ylabel('Angle (°)');

s4 = subplot(4,1,4); hold on; grid on;
plot(actuator_values.N_rpm);
n_cmd = CreateCmd(inputs.command.speed, inputs.Flag.FlagForward, 0);
plot(n_cmd); clear n_cmd;
legend('N','N_{command}');
title('N');xlabel('time (s)'); ylabel('RPM');

linkaxes([s1 s2 s3 s4],'x'); clear s1 s2 s3 s4;
% %% Forces
% figure('name','forces','units','normalized','outerposition',[0 0 1 1]);
% s1 = subplot(3,1,1); hold on; grid on;
% plot(forces_values.ActuatorForces.HelmsForces.Fx_N);
% plot(forces_values.ActuatorForces.ThrusterForces.Fx_N);
% plot(forces_values.CoriolisForces.Fx_N);
% plot(forces_values.RestoringForces.Fx_N);
% plot(forces_values.HydrodynamicForces.Fx_N);
% legend('Helms','Thruster','Coriolis','Restoring','Hydrodynamic');
% xlabel('times (s)'); ylabel('Force (N)');
% title('F_X');
% 
% s2 = subplot(3,1,2); hold on; grid on;
% plot(forces_values.ActuatorForces.HelmsForces.Fy_N);
% plot(forces_values.ActuatorForces.ThrusterForces.Fy_N);
% plot(forces_values.CoriolisForces.Fy_N);
% plot(forces_values.RestoringForces.Fy_N);
% plot(forces_values.HydrodynamicForces.Fy_N);
% legend('Helms','Thruster','Coriolis','Restoring','Hydrodynamic');
% xlabel('times (s)'); ylabel('Force (N)');
% title('F_Y');
% 
% s3 = subplot(3,1,3); hold on; grid on;
% plot(forces_values.ActuatorForces.HelmsForces.Fz_N);
% plot(forces_values.ActuatorForces.ThrusterForces.Fz_N);
% plot(forces_values.CoriolisForces.Fz_N);
% plot(forces_values.RestoringForces.Fz_N);
% plot(forces_values.HydrodynamicForces.Fz_N);
% legend('Helms','Thruster','Coriolis','Restoring','Hydrodynamic');
% xlabel('times (s)'); ylabel('Force (N)');
% title('F_Z');
% 
% linkaxes([s1 s2 s3],'x'); clear s1 s2 s3;
% %% Torques
% figure('name','torques','units','normalized','outerposition',[0 0 1 1]);
% s1 = subplot(3,1,1); hold on; grid on;
% plot(forces_values.ActuatorForces.HelmsForces.Mx_Nm);
% plot(forces_values.ActuatorForces.ThrusterForces.Mx_Nm);
% plot(forces_values.CoriolisForces.Mx_Nm);
% plot(forces_values.RestoringForces.Mx_Nm);
% plot(forces_values.HydrodynamicForces.Mx_Nm);
% legend('Helms','Thruster','Coriolis','Restoring','Hydrodynamic');
% xlabel('times (s)'); ylabel('Torque (N.m)');
% title('M_X');
% 
% s2 = subplot(3,1,2); hold on; grid on;
% plot(forces_values.ActuatorForces.HelmsForces.My_Nm);
% plot(forces_values.ActuatorForces.ThrusterForces.My_Nm);
% plot(forces_values.CoriolisForces.My_Nm);
% plot(forces_values.RestoringForces.My_Nm);
% plot(forces_values.HydrodynamicForces.My_Nm);
% legend('Helms','Thruster','Coriolis','Restoring','Hydrodynamic');
% xlabel('times (s)'); ylabel('Torque (N.m)');
% title('M_Y');
% 
% s3 = subplot(3,1,3); hold on; grid on;
% plot(forces_values.ActuatorForces.HelmsForces.Mz_Nm);
% plot(forces_values.ActuatorForces.ThrusterForces.Mz_Nm);
% plot(forces_values.CoriolisForces.Mz_Nm);
% plot(forces_values.RestoringForces.Mz_Nm);
% plot(forces_values.HydrodynamicForces.Mz_Nm);
% legend('Helms','Thruster','Coriolis','Restoring','Hydrodynamic');
% xlabel('times (s)'); ylabel('Torque (N.m)');
% title('M_Z');
% 
% linkaxes([s1 s2 s3],'x'); clear s1 s2 s3;
% 
% %% Total forces and torques
% figure('name','total forces and torques','units','normalized','outerposition',[0 0 1 1]);
% s1 = subplot(3,2,1);
% plot(forces_values.TotalForces.Fx_N); grid on;
% xlabel('times (s)'); ylabel('Force (N)');
% title('Total F_X');
% 
% s2 = subplot(3,2,3);
% plot(forces_values.TotalForces.Fy_N); grid on;
% xlabel('times (s)'); ylabel('Force (N)');
% title('Total F_Y');
% 
% s3 = subplot(3,2,5);
% plot(forces_values.TotalForces.Fy_N); grid on;
% xlabel('times (s)'); ylabel('Force (N)');
% title('Total F_Z');
% 
% s4 = subplot(3,2,2);
% plot(forces_values.TotalForces.Mx_Nm); grid on;
% xlabel('times (s)'); ylabel('Torque (N.m)');
% title('Total M_X');
% 
% s5 = subplot(3,2,4);
% plot(forces_values.TotalForces.My_Nm); grid on;
% xlabel('times (s)'); ylabel('Torque (N.m)');
% title('Total M_Y');
% 
% s6 = subplot(3,2,6);
% plot(forces_values.TotalForces.Mz_Nm); grid on;
% xlabel('times (s)'); ylabel('Torque (N.m)');
% title('Total M_Z');
% 
% linkaxes([s1 s2 s3 s4 s5 s6],'x'); clear s1 s2 s3 s4 s5 s6;
%% Get warning back
warning on;