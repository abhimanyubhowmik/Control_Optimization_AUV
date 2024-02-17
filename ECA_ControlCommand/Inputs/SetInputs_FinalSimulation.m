function inputs = SetInputs_FinalSimulation(sample_time_s,simulation_time_s)
% Create inputs for the simulation that will validate the performance of your Control
%
% :usage: inputs = SetInputs_FinalSimulation(sample_time_s,simulation_time_s)
%
% :param sample_time_s: sample time of the simulation (s)
% :param simulation_time_s: time of the simulation (s)
%
% :returns:
%   * inputs - structure with flag command and command values


% The purpose of this function is to do a typical mission for an AUV,
% called a "survey". It is composed of a straight line (rail)
% and a rail turnaround to chain another rail in the other direction

%% Flag command
% 0 = openloop BAR, 1 = Depth, 2 = Pitch
inputs.Flag.FlagVertical = timeseries(1,0:sample_time_s:simulation_time_s);

% 0 = openloop G, 1 = Roll
inputs.Flag.FlagRoll = timeseries(1,0:sample_time_s:simulation_time_s);

% 0 = openloop RPM, 1 = ForwardSpeed
inputs.Flag.FlagForward = timeseries(1,0:sample_time_s:simulation_time_s);

%% Command values
inputs.command.roll = timeseries(0,0:sample_time_s:simulation_time_s);
inputs.command.speed = timeseries(2,0:sample_time_s:simulation_time_s);
inputs.command.vertical = timeseries(10,0:sample_time_s:simulation_time_s);

%% Special heading command
% A rail of 500m at 2m/s => 250s
% 60s to turn around and a new rail
heading_cmd_rad = deg2rad([90; 90; 270; 270; 90 ; 270]);
heading_time_s = [0; 250; 310; 560; 620; 870];

inputs.command.horizontal = timeseries(heading_cmd_rad,heading_time_s);

% 0 = openloop A, 1 = Heading
inputs.Flag.FlagHorizontal = inputs.command.horizontal;
inputs.Flag.FlagHorizontal.Data(:) = 1;

%% Seabed by default , you don't need to change it
inputs.seabed_m = timeseries(60,0:sample_time_s:simulation_time_s);
end