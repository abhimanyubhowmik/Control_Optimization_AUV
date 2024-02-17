function memory = UpdatePilotRollMemory(in,memory,param)
% Updates the memory of the integral
%
% :usage: memory = UpdatePilotRollMemory(in,memory,param)
%
% :param in: Required inputs for updating the memory
% :param memory: Piloting memory
% :param param: Parameters required for full term memory
%
% :returns:
%   * memory - memory on integral terms

%% Update of the memory values
current_error = -DiffAngle(in.phic_rad,in.phi_rad);
previous_error = memory.previous_error;
    
% Naive anti windup
if abs(current_error) <= param.limit_integral_term 
    % If the final error is small: activation and update of the full term
    memory.int_phi =  EcaF_Integrate(memory.int_phi, previous_error,...
        current_error, in.delta_time_s);
    memory.previous_error = current_error;
else
    % Otherwise reset to 0 of the integral
   memory.previous_error = 0;
   memory.int_phi = 0;
end

end