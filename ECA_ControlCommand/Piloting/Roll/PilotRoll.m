function Out = PilotRoll(in, memory, parameters)
% Roll piloting

%% Compute deltas
delta_phi = DiffAngle(in.phic_rad,in.phi_rad);
delta_phi = EcaF_Saturate(delta_phi,-parameters.delta_phi_sat_rad,...
    parameters.delta_phi_sat_rad);

delta_p = 0.0 - in.p_rads;

Gc_rad = parameters.Kp*delta_phi + parameters.Ki*memory.int_phi*delta_phi + parameters.Kd*delta_p;

%% Output saturation
Out.Gc = EcaF_Saturate(Gc_rad,parameters.G_sat_rad(1),parameters.G_sat_rad(2));

end
