function hydrodynamic_forces = ComputeHydrodynamicForce(speed_ms,angular_speed_rads,parameters)
% Compute hydrodynamic forces
%
% :usage: hydrodynamic_forces = ComputeHydrodynamicForce(speed_ms,angular_speed_rads,parameters)
%
% :param speed_ms: speed vector [u,v,w] in m/s
% :param angular_speed_rads: angular speed vector [p,q,r] in rad/s
% :param parameters: hydrodynamic parameters of the vehicule
%
% :returns:
%   * hydrodynamic_forces - vector of hydrodynamic forces [Fx,Fy,Fz,Mx,My,Mz]

%% Loas the parameters
% speed_ms = [U V W]' and angular_speed_rads = [P Q R]'
U_ms = speed_ms(1);
V_ms = speed_ms(2);
W_ms = speed_ms(3);
P_rads = angular_speed_rads(1);
Q_rads = angular_speed_rads(2);
R_rads = angular_speed_rads(3);

% Vehicle caracteristics
Lref_m = parameters.Lref;
Sref_m2 = parameters.Sref;
rho = parameters.Rho;
v = parameters.nu;

% Surge parameters
Ksh = parameters.Ksh;

% Sway parameters
CYuv = parameters.CYuv;
CYur = parameters.CYur;

% Lift parameters
CZ0 = parameters.CZ0;
CZuw = parameters.CZuw;
CZuq = parameters.CZuq;

% Roll parameters
CLup = parameters.CLup;

% Pitch parameters
CM0 = parameters.CM0;
CMuw = parameters.CMuw;
CMuq = parameters.CMuq;

% Yaw parameters
CNuv = parameters.CNuv;
CNur = parameters.CNur;

%% Compute hydrodynamic damping
% Available solution if U > 0.5
Vrefar = U_ms;

% Null speed isn't allowed, in this case we put very small values
if Vrefar == 0
    Vrefar = 0.01;
end

% CXF
Re = abs(Vrefar)*Lref_m/v;
CXF = 0.075/((log10(Re)-2)^2);

% forces
Fx = 0.5.*rho.*Sref_m2.*(Ksh*CXF).*U_ms.*abs(U_ms);
Fy = 0.5.*rho.*Sref_m2.*(CYuv.*U_ms.*V_ms + Lref_m.*CYur.*U_ms.*R_rads);
Fz = 0.5.*rho.*Sref_m2.*(CZ0.*U_ms.^2 + CZuw.*U_ms.*W_ms + Lref_m.*CZuq.*U_ms.*Q_rads);

Mx = 0.5.*rho.*Sref_m2.*Lref_m.^2.*(CLup.*U_ms.*P_rads);
My = 0.5.*rho.*Sref_m2.*Lref_m.*(CM0.*U_ms.^2 + CMuw.*U_ms.*W_ms + Lref_m.*CMuq.*U_ms.*Q_rads);
Mz = 0.5.*rho.*Sref_m2.*Lref_m.*(CNuv.*U_ms.*V_ms + Lref_m.*CNur.*U_ms.*R_rads);

hydrodynamic_forces = [Fx; Fy; Fz; Mx; My; Mz];

end