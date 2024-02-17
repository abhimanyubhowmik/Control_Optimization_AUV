function noise = ApplyNoise(sample_time_s)
% Configuration file which allows you to define adding noise to actuators, measurements and controls
%
% noise = ApplyNoise(sample_time_s)
%
% :param sample_time_s: sample time of the simulation (s)

%%  Noise on outputs
noise =[];

noise = AddedNoise(noise,'Ueau_ms','off',0.001,sample_time_s);
noise = AddedNoise(noise,'Veau_ms','off',0.01,sample_time_s);
noise = AddedNoise(noise,'Weau_ms','off',0.01,sample_time_s);
noise = AddedNoise(noise,'P_rads','off',0,sample_time_s);
noise = AddedNoise(noise,'Q_rads','off',0.01,sample_time_s);
noise = AddedNoise(noise,'R_rads','off',0.01,sample_time_s);

noise = AddedNoise(noise,'x_m','off',0,sample_time_s);
noise = AddedNoise(noise,'y_m','off',0,sample_time_s);
noise = AddedNoise(noise,'z_m','off',0,sample_time_s);
noise = AddedNoise(noise,'Phi_rad','off',0,sample_time_s);
noise = AddedNoise(noise,'Theta_rad','off',0.005,sample_time_s);
noise = AddedNoise(noise,'Psi_rad','off',0,sample_time_s);
noise = AddedNoise(noise,'Psiroute_rad','off',0,sample_time_s);

noise = AddedNoise(noise,'A_rad','off',0.01,sample_time_s);
noise = AddedNoise(noise,'G_rad','off',0,sample_time_s);
noise = AddedNoise(noise,'BAR_rad','off',0,sample_time_s);
noise = AddedNoise(noise,'RPM','off',0,sample_time_s);

if isempty(noise)
    noise = 'aucune';
end
end

function noise = AddedNoise(noise,variable,state,noise_power_value,sample_time_s)
% Add a noise to the noised list
%
% :usage: noise = AddedNoise(noise,variable,state,noise_power)
%
% :param noise: noise list
% :param variable: name of the variable (string)
% :param state: 'on' or 'off'
% :param noise_power_value: Noise spectral density
% :param sample_time_s: sample time in seconds
%
% :returns:
%   * noise - noise list with the new variable

if strcmp(state,'off')
    noise.(variable).noise_power = 0;
else
    noise.(variable).noise_power = noise_power_value^2/sample_time_s;
end
end