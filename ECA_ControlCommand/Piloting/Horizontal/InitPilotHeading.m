function memory = InitPilotHeading()
% Initialization of the memory
%
% :usage: memory = InitPilotHeading()

memory.int_psi = 0.0;

% Memory value init on psi_rad
memory.current_error = 0.0;
memory.previous_error = 0.0;

end