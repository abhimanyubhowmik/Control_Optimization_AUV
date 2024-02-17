function out = PilotHeading(in, memory, parameters)
% Heading piloting

%% Compute deltas
delta_psi = DiffAngle(in.psi_rad,in.psic_rad);
delta_psi = EcaF_Saturate(delta_psi,-parameters.delta_psi_sat_rad,...
    parameters.delta_psi_sat_rad);

delta_r = 0.0 - in.r_rads;

% A>0 => Fy >0
Ac_rad = parameters.Kp*delta_psi + parameters.Ki*memory.int_psi*delta_psi + parameters.Kd*delta_r;

%% Output saturation
out.Ac = EcaF_Saturate(Ac_rad,parameters.A_sat_rad(1),parameters.A_sat_rad(2));

end
