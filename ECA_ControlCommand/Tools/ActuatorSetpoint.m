function outputs = ActuatorSetpoint(inputs, Bmax_rad)
% compute of actuator setpoints based on setpoints at level different axes as well as presence og flags of different control surfaces
%
% :usage: outputs = ActuatorSetpoint(inputs, parameters)
%
% :param inputs: inputs struct with Ac_rad, Gc_rad and BARc_rad
% :param Bmax_rad: Max angle available by control helms
%
% :returns:
%   * outputs - output struct with B1c_rad, B2c_rad, B3c_rad and B4c_rad

%% Virtual angle control D = 0 if the control surfaces are working properly.
% Command to complete the linear system for converting virtual setpoints
% to physical bar setpoints information not currently used.
D_rad = 0;

%% Initialization of outputs
outputs.B1c_rad = single(0);
outputs.B2c_rad = single(0);
outputs.B3c_rad = single(0);
outputs.B4c_rad = single(0);

%% Compute of bacward helms outputs
Acor = inputs.Ac_rad*cos(inputs.Phi_rad) - inputs.BARc_rad*sin(inputs.Phi_rad);
BARcor = inputs.BARc_rad*cos(inputs.Phi_rad) + inputs.Ac_rad*sin(inputs.Phi_rad);
[BAR_rad,A_rad,G_rad] = SaturateHelms(BARcor,Acor,inputs.Gc_rad,Bmax_rad);

outputs.B1c_rad = (G_rad - BAR_rad + A_rad - D_rad)/4;
outputs.B2c_rad = (G_rad - BAR_rad - A_rad + D_rad)/4;
outputs.B3c_rad = (G_rad + BAR_rad - A_rad - D_rad)/4;
outputs.B4c_rad = (G_rad + BAR_rad + A_rad + D_rad)/4;
end


