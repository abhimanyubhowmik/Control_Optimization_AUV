% Creation of the bus for simulink project
%
% :usage: CreateSimulinkBus;
%
% :returns:
%   * all necessary bus for the simulation
%
% :warning: has to be a script because the bus are created in the base workspace

% It's a script so if we call it again, we first delete all the Bus (can't
% rewrite a bus in this way)
all_data_in_workspace = whos();
for j = 1:length(all_data_in_workspace)
    if strcmp(all_data_in_workspace(j).class,'Simulink.Bus')
        clear(all_data_in_workspace(j).name);
    end
end
clear j all_data_in_workspace
%% Creation of basic data type as speed, position, angle, ...
Datatype.WaterSpeed.Uwater_ms = 0.0;
Datatype.WaterSpeed.Vwater_ms = 0.0;
Datatype.WaterSpeed.Wwater_ms = 0.0;

Datatype.EulerAngles.Phi_rad = 0.0;
Datatype.EulerAngles.Theta_rad = 0.0;
Datatype.EulerAngles.Psi_rad = 0.0;
Datatype.EulerAngles.Psiroute_rad = 0.0;

Datatype.Position.x_m = 0.0;
Datatype.Position.y_m = 0.0;
Datatype.Position.z_m = 0.0;

Datatype.AngularSpeed.P_rads = 0.0;
Datatype.AngularSpeed.Q_rads = 0.0;
Datatype.AngularSpeed.R_rads = 0.0;

Datatype.Forces.Fx_N = 0.0;
Datatype.Forces.Fy_N = 0.0;
Datatype.Forces.Fz_N = 0.0;
Datatype.Forces.Mx_Nm = 0.0;
Datatype.Forces.My_Nm = 0.0;
Datatype.Forces.Mz_Nm = 0.0;
%% Creation of the Vehicle State and actuators
VehicleState.eta.rABS_Position =        Datatype.Position;
VehicleState.eta.EulerAngles =          Datatype.EulerAngles;
VehicleState.nu.rAUV_WaterSpeed =       Datatype.WaterSpeed;
VehicleState.nu.AngularSpeed =          Datatype.AngularSpeed;

% Actuators
ActuatorState.physical_helms.B1_rad = 0.0;
ActuatorState.physical_helms.B2_rad = 0.0;
ActuatorState.physical_helms.B3_rad = 0.0;
ActuatorState.physical_helms.B4_rad = 0.0;

ActuatorState.virtual_helms.A_rad = 0.0;
ActuatorState.virtual_helms.BAR_rad = 0.0;
ActuatorState.virtual_helms.G_rad = 0.0;

ActuatorState.N_rpm = 0.0;

%% Bus for flag command
Flag.FlagHorizontal = 0;
Flag.FlagRoll = 0;
Flag.FlagForward = 0;
Flag.FlagVertical = 0;

%% Forces
Forces.ActuatorForces.HelmsForces = Datatype.Forces;
Forces.ActuatorForces.ThrusterForces = Datatype.Forces;
Forces.CoriolisForces = Datatype.Forces;
Forces.RestoringForces = Datatype.Forces;
Forces.HydrodynamicForces = Datatype.Forces;
Forces.TotalForces = Datatype.Forces;

%% Conversion to Bus + renaming
Simulink.Bus.createObject(VehicleState);
VehicleState = slBus1;

Simulink.Bus.createObject(ActuatorState);
ActuatorState = slBus2;

Simulink.Bus.createObject(Flag);
Flag = slBus3;

Simulink.Bus.createObject(Forces);
Forces = slBus4;

%% Clean because it's a script
clear Datatype slBus* i name