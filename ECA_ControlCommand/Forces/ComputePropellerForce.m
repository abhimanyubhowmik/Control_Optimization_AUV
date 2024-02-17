function F_prop = ComputePropellerForce(parameters,nc_saturated_trmin,speed_ms)
% Compute thruster(=Propeller) forces
%
% :usage: thruster_forces = ComputeHelmsForce(parameters,virtual_helms,speed_ms)
%
% :param parameters: helms parameters of the vehicule
% :param nc_saturated_trmin: RPM command , saturated, in tr/min
% :param speed_ms: speed vector [u,v,w] in m/s
%
% :returns:
%   * thruster_forces - vector of thruster forces [Fx,Fy,Fz,Mx,My,Mz]
%
% :note:
%  As Fossen in 4.1 : ROV Equations of Motion, 4.1.1 : Truster Model, p94-p95

% Variables recovery
T_n_n = parameters.T_n_n;
T_n_u = parameters.T_n_u;
Q_n_n = parameters.Q_n_n;
Q_n_u = parameters.Q_n_u;

% Convert tr/min into tr/s
n_trs = nc_saturated_trmin/60;

u_ms = speed_ms(1);

%% Compute forces
Fx =  T_n_n.*n_trs.*abs(n_trs) + T_n_u.*abs(n_trs).*u_ms;
Fy =  0;
Fz =  0;
Mx =  Q_n_n.*n_trs.*abs(n_trs) + Q_n_u.*abs(n_trs).*u_ms;
My =  0;
Mz =  0;

F_prop = [Fx; Fy; Fz;Mx; My; Mz];

end

