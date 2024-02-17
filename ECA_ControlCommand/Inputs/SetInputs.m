function inputs = SetInputs(sample_time_s,simulation_time_s)
% Create inputs for the simulation : command and flag
%
% :usage: inputs = SetInputs(sample_time_s,simulation_time_s)
%
% :param sample_time_s: sample time of the simulation (s)
% :param simulation_time_s: time of the simulation (s)
%
% :returns:
%   * inputs - structure with flag command and command values

%% Flag command
% 0 = openloop A, 1 = Heading
inputs.Flag.FlagHorizontal = timeseries(1,0:sample_time_s:simulation_time_s);

% 0 = openloop G, 1 = Roll
inputs.Flag.FlagRoll = timeseries(1,0:sample_time_s:simulation_time_s);

% 0 = openloop RPM, 1 = ForwardSpeed
inputs.Flag.FlagForward = timeseries(1,0:sample_time_s:simulation_time_s);

% 0 = openloop BAR, 1 = Depth, 2 = Pitch
inputs.Flag.FlagVertical = timeseries(1,0:sample_time_s:simulation_time_s);

%% Command values
inputs.command.horizontal = timeseries(deg2rad(90),0:sample_time_s:simulation_time_s);
inputs.command.speed = timeseries(2,0:sample_time_s:simulation_time_s);
inputs.command.roll = timeseries(0,0:sample_time_s:simulation_time_s);
inputs.command.vertical = timeseries(15,0:sample_time_s:simulation_time_s);

%% Seabed by default , you don't need to change it
inputs.seabed_m = timeseries(100,0:sample_time_s:simulation_time_s);
end

