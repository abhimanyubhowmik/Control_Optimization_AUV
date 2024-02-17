function [ Mat ] = MatRot( phi,theta,psi )
% Matrice de rotation du repère veh -> repère R0
%
% :usage: [ Mat ] = MatRot( phi,theta,psi )
%
% :param phi: (rad) Angle de roulis
% :param theta: (rad) Angle d'assiette
% :param psi: (rad) Angle de cap
%
% :returns: Mat : Matrice 3x3 de rotation repère veh -> repère R0

Mat=zeros(3,3);
Mat(1,1) = cos(theta)*cos(psi);
    Mat(2,1) = cos(theta)*sin(psi);
    Mat(3,1) = -sin(theta);

    Mat(1,2) = (sin(phi)*sin(theta)*cos(psi) - cos(phi)*sin(psi));
    Mat(2,2) = (sin(phi)*sin(theta)*sin(psi) + cos(phi)*cos(psi));
    Mat(3,2) = sin(phi)*cos(theta);

    Mat(1,3) = (cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi));
    Mat(2,3) = (cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi));
    Mat(3,3) = cos(phi)*cos(theta);

end

