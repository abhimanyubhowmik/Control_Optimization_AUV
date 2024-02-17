function helms_forces = ComputeHelmsForce(parameters,virtual_helms,speed_ms)
% Compute helms forces
%
% :usage: helms_forces = ComputeHelmsForce(parameters,virtual_helms,speed_ms)
%
% :param parameters: helms parameters of the vehicule
% :param virtual_helms: virtual helms angle [BAR,A,G] in rad
% :param speed_ms: speed vector [u,v,w] in m/s
%
% :returns:
%   * coriolis_forces - vector of coriolis forces [Fx,Fy,Fz,Mx,My,Mz]

% Variables recovery
U_ms = speed_ms(1);
A = virtual_helms(1);
G = virtual_helms(2);
BAR = virtual_helms(3);

Rho = parameters.Rho;
Sref = parameters.Sref;
Lref = parameters.Lref;

CX = parameters.CX;
CY = parameters.CY;
CZ = parameters.CZ;
CL = parameters.CL;
CM = parameters.CM;
CN = parameters.CN;

%% Compute the forces
Fx =  1/8.*Rho.*Sref.*CX.*(BAR.^2+A.^2+G.^2).*abs(U_ms).*U_ms;
Fy =  0.5.*Rho.*Sref.*CY.*A.*abs(U_ms).*U_ms;
Fz =  0.5.*Rho.*Sref.*CZ.*BAR.*abs(U_ms).*U_ms;

Mx = 0.5.*Rho.*Sref.*Lref.*CL.*G.*abs(U_ms).*U_ms;
My = 0.5.*Rho.*Sref.*Lref.*CM.*BAR.*abs(U_ms).*U_ms;
Mz = 0.5.*Rho.*Sref.*Lref.*CN.*A.*abs(U_ms).*U_ms;

helms_forces = [Fx; Fy; Fz; Mx; My; Mz];

end

