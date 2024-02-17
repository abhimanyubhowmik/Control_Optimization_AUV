function inputs = SetInputs_SpeedSteps(sample_time_s,simulation_time_s)
% Create inputs for the simulation of speed steps
%
% :usage: inputs = SetInputs_SpeedSteps(sample_time_s,simulation_time_s)
%
% :param sample_time_s: sample time of the simulation (s)
% :param simulation_time_s: time of the simulation (s)
%
% :returns:
%   * inputs - structure with flag command and command values

%% Flag command
% 0 = openloop A, 1 = Heading
inputs.Flag.FlagHorizontal = timeseries(0,0:sample_time_s:simulation_time_s);

% 0 = openloop G, 1 = Roll
inputs.Flag.FlagRoll = timeseries(1,0:sample_time_s:simulation_time_s);

% 0 = openloop BAR, 1 = Depth, 2 = Pitch
inputs.Flag.FlagVertical = timeseries(1,0:sample_time_s:simulation_time_s);

%% Command values
inputs.command.horizontal = timeseries(deg2rad(0),0:sample_time_s:simulation_time_s);
inputs.command.roll = timeseries(0,0:sample_time_s:simulation_time_s);
inputs.command.vertical = timeseries(10,0:sample_time_s:simulation_time_s);

%% Special speed command for steps
stabilization_time_s = 500;
step_time_s = 150;
inputs.command.speed = timeseries(...
    [1; 1; [1.1:0.1:2.5 2.5:-0.1:1]'], .... %1 for stabilisation and after steps
    [0 stabilization_time_s ... % from to to stabilization_time_s
    stabilization_time_s+step_time_s:step_time_s:simulation_time_s]); % Speed steps

% 0 = openloop RPM, 1 = ForwardSpeed
inputs.Flag.FlagForward = inputs.command.speed;
inputs.Flag.FlagForward.Data(:) = 1;

%% Seabed by default , you don't need to change it
inputs.seabed_m = timeseries(100,0:sample_time_s:simulation_time_s);
end