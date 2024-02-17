function coriolis_forces = ComputeCoriolisForces(speed_ms,angular_speed_rads ,...
    gravity_center_m, mass_kg,inertia_matrix)
% Compute coriolis forces
%
% :usage: coriolis_forces = ComputeCoriolisForces(speed_ms,angular_speed_rads ,...gravity_center_m, mass_kg,inertia_matrix)
%
% :param speed_ms: speed vector [u,v,w] in m/s
% :param angular_speed_rads: angular speed vector [p,q,r] in rad/s
% :param gravity_center_m: 
%   Position of the center of gravity in relation to the center 
%   of expression of the forces
% :param mass_kg: vehicule mass in Kg
% :param inertia_matrix: Vehicle inertia matrix 3x3
%
% :returns:
%   * coriolis_forces - vector of coriolis forces [Fx,Fy,Fz,Mx,My,Mz]

SV1 = SkewMatrix(speed_ms);
SV2 = SkewMatrix(angular_speed_rads);
SG = SkewMatrix(gravity_center_m);

% CRB matrix definition as in the FOSSEN
CRB11 =     zeros(3,3);
CRB12 =     -mass_kg*(SV1 + SV2*SG );
CRB21 =     mass_kg*(-SV1 + SG*SV2);
CRB22 =     -SkewMatrix(inertia_matrix * angular_speed_rads);

CRB=    [   CRB11   CRB12
            CRB21   CRB22];

V = [speed_ms;angular_speed_rads];
coriolis_forces = - CRB*V;
end