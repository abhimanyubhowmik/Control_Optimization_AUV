function memory = InitPilotDepth()
% Initialization of the memory
%
% :usage: memory = InitPilotDepth()

memory.int_z = 0.0;

% Memory value init on psi_rad
memory.current_error = 0.0;
memory.previous_error = 0.0;

end