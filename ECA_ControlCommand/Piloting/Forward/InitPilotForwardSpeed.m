function memory = InitPilotForwardSpeed()
% Initialization of the integral for piloting with respect to water with propeller actuator.
%
% :usage: memory = InitPilotForwardSpeedRPM()

% Reset de l'intégrateur

memory.int_u = 0.0;

% Memory value init on psi_rad
memory.current_error = 0.0;
memory.previous_error = 0.0;

end
