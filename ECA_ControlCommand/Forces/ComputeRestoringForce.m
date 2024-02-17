function restoring_forces = ComputeRestoringForce(EulerAngles,mecanic_data)
% Compute restoring forces
%
% :usage: restoring_forces = ComputeRestoringForce(EulerAngles,mecanic_data)
%
% :param EulerAngles: [rall,pitch,yaw] in rad
% :param mecanic_data: 
%   Data from the mecanic model as mass_kg, gravity_center_m,
%   buoyancy_center_m, ...
%
% :returns:
%   * restoring_forces - vector of restoring forces [Fx,Fy,Fz,Mx,My,Mz]

mass_kg = mecanic_data.Mecanic.mass;
gravity_center_m = mecanic_data.Mecanic.center_of_gravity_veh_ref;
buoyancy_center_m = mecanic_data.Mecanic.center_of_buoyancy_veh_ref;

% Variables recovery
roll_rad = EulerAngles.Phi_rad;
pitch_rad = EulerAngles.Theta_rad;
W_N = mass_kg*9.81;
B_N = mecanic_data.Mecanic.volume*9.81*mecanic_data.Environment.Rho;

sth  = sin(pitch_rad); cth  = cos(pitch_rad);
sphi = sin(roll_rad); cphi = cos(roll_rad);

% ATTENTION aux espaces avant et après les parenthèses !
restoring_forces = [...
    0;...
    0;...
    (W_N - B_N)*cth*cphi;...
    -(gravity_center_m(3)*W_N-buoyancy_center_m(3)*B_N)*cth*sphi;...
    -(gravity_center_m(3)*W_N-buoyancy_center_m(3)*B_N)*sth;...
   0];
end