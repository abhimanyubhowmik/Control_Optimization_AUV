function [BAR_rad,A_rad,G_rad] = SaturateHelms(BAR_rad,A_rad,G_rad,Bmax_rad)
% Saturate virtual helms according to a maximum quantity per angle noted Bmax
%
% :usage: [BAR_rad,A_rad,G_rad] = SaturateHelms(BAR_rad,A_rad,G_rad,Bmax_rad)
%
% :param BAR_rad: Vertical virtual actuator
% :param A_rad: Horizontal virtual actuator
% :param G_rad: Roll virtual actuator
% :param Bmax_rad: Max angle available by control helms
%
% :returns:
%   * BAR_rad - Vertical virtual actuator prioritized
%   * A_rad - Horizontal virtual actuator prioritized
%   * G_rad - Roll virtual actuator prioritized

BAR_rad =	EcaF_Saturate( BAR_rad, -4 * Bmax_rad, 4*Bmax_rad);
A_rad =     EcaF_Saturate( A_rad, -4 * Bmax_rad, 4*Bmax_rad);
G_rad =     EcaF_Saturate( G_rad, -4 * Bmax_rad , 4*Bmax_rad);
end