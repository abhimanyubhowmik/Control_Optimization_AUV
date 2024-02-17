function memory = UpdatePilotDepthMemory(in,memory,param)
% Updates the memory of the integral
%
% :usage: memory = UpdatePilotDepthMemory(in,memory,param)
%
% :param in: Required inputs for updating the memory
% :param memory: Piloting memory
% :param param: Parameters required for full term memory
%
% :returns:
%   * memory - memory on integral terms

%% Update of the memory values
current_error = in.zc_m - in.z_m;
current_error = EcaF_Saturate(current_error,-param.delta_z_sat_m,param.delta_z_sat_m);
previous_error = memory.previous_error;
    
% Naive anti windup
if abs(current_error) <= param.limit_integral_term 
    % If the final error is small: activation and update of the full term
    memory.int_z =  EcaF_Integrate(memory.int_z, previous_error,...
        current_error, in.delta_time_s);
    memory.previous_error = current_error;
else
    % Otherwise reset to 0 of the integral
   memory.previous_error = 0;
   memory.int_z = 0;
end

end