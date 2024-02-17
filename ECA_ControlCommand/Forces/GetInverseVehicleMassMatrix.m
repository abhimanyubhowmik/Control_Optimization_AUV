function inverse_veh_mass_matrix = GetInverseVehicleMassMatrix(parameters)
% Compute the inverse of the vehicle mass matrix
%
% :usage: inverse_veh_mass_matrix = GetInverseVehicleMassMatrix(parameters)
%
% :param parameters:
%   parameters of the vehicule as inertia matrix, mass ,added water,
%   position of gravity center, ...
%
% :returns:
%   * inverse_veh_mass_matrix - inverse of the vehicle mass matrix (6x6)

%% Get the parameters and intermediate calculation
m_kg = parameters.mass_with_on_board_water;
zG_m = parameters.center_of_gravity_veh_ref(3);

S = m_kg*[0     zG_m	0;...
          -zG_m 0       0;...
          0     0       0 ];

%% Compute Vehicle "mecaninal mass"
mecanic_matrix= [...
    eye(3)*m_kg    S; ...
    -S             parameters.inertia_matrix];

%% The total mass of the vehicle is the mecanic mass + added water matrix
total_vehicle_mass_matrix= mecanic_matrix + parameters.added_water_matrix;

inverse_veh_mass_matrix = inv(total_vehicle_mass_matrix);
end