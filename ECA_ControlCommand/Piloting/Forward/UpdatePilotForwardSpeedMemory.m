function memory = UpdatePilotForwardSpeedMemory(in,memory,param)
% Updates the memory of the integral
%
% :usage: memory = UpdatePilotForwardSpeedMemory(in,memory,param)
%
% :param in: Required inputs for updating the memory
% :param memory: Piloting memory
% :param param: Parameters required for full term memory
%
% :returns:
%   * memory - memory on integral terms

%% Update of the memory values
current_error = in.uc_ms - in.u_ms;      
previous_error = memory.previous_error;

% Naive anti windup
if in.u_ms >= param.u_min_ms
    % If the speed is higher than the minimum speed
    memory.int_u = EcaF_Integrate(memory.int_u , previous_error, ...
        current_error, in.delta_time_s);
    memory.previous_error = current_error;
else
    % Otherwise reset to 0 of the integral
    memory.previous_error = 0.0;
    memory.int_u = 0.0;
end

end