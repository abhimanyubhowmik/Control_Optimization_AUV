function angleOut = Mod2Pi(angleIn)
% Fonction modulo 2pi
%
% :usage: angleOut = Mod2Pi(angleIn)
% :param angleIn: angle (rad)
% :returns: angleOut : -pi <= angleIn <= pi

angleOut = mod(angleIn,2*pi);
if angleOut>pi
    angleOut=angleOut-2*pi;
end
end