function Y = DiffAngle(a2,a1)
% Angle difference. Takes into account angles mod(2 pi).
% Used in Kalman filters to avoid singularities when comparing two angles
% 
% :usage: Y = DiffAngle(a2,a1)
%
% :param a2: First angle (rad)
% :param a1: Second angle (rad)
%
% :returns: (a2 - a1) mod 2*pi

d = a2-a1;
Y = Mod2Pi(d);
end