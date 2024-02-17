function out = PilotPitch(in, parameters)
% Pitch piloting

%% Compute deltas
delta_theta = DiffAngle(in.thetac_rad,in.theta_rad);
delta_theta = EcaF_Saturate(delta_theta,-parameters.theta_sat_rad,...
    parameters.theta_sat_rad);

delta_q = 0.0 - in.q_rads;

% Minus because BAR>0 => F<0 => Theta<0
BARc_rad = - parameters.Kp*delta_theta - parameters.Kd*delta_q;

%% Output saturation
out.BARc = EcaF_Saturate(BARc_rad,parameters.BAR_sat_rad(1),parameters.BAR_sat_rad(2));

end
