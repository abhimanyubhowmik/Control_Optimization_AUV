function inputs = SetInputs_DieuDonnee(sample_time_s,simulation_time_s)
% Create inputs for the simulation of speed steps
%
% :usage: inputs = SetInputs_DieuDonnee(sample_time_s,simulation_time_s)
%
% :param sample_time_s: sample time of the simulation (s)
% :param simulation_time_s: time of the simulation (s)
%
% :returns:
%   * inputs - structure with flag command and command values

%% Flag command
% 0 = openloop G, 1 = Roll
inputs.Flag.FlagRoll = timeseries(1,0:sample_time_s:simulation_time_s);

% 0 = openloop BAR, 1 = Depth, 2 = Pitch
inputs.Flag.FlagVertical = timeseries(1,0:sample_time_s:simulation_time_s);

% 0 = openloop RPM, 1 = ForwardSpeed
inputs.Flag.FlagForward = timeseries(1,0:sample_time_s:simulation_time_s);

%% Command values
inputs.command.roll = timeseries(0,0:sample_time_s:simulation_time_s);
inputs.command.vertical = timeseries(10,0:sample_time_s:simulation_time_s);
inputs.command.speed = timeseries(2.5,0:sample_time_s:simulation_time_s);

%% Special speed command for steps
step_time_s = 0.2;
inputs.command.horizontal = timeseries(...
    deg2rad([-120 -120:1:120 120:-1:-120 -120]'),0:step_time_s:simulation_time_s);

% 0 = openloop A, 1 = Heading
inputs.Flag.FlagHorizontal = inputs.command.horizontal;
inputs.Flag.FlagHorizontal.Data(:) = 0;

%% Seabed by default , you don't need to change it
inputs.seabed_m = timeseries(100,0:sample_time_s:simulation_time_s);
end