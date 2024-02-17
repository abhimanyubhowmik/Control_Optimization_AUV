% load physical parameters
auv_param = loadjson('Conf/AUVParameters.json');

CYuv = -1;
CYur = 2;
CZuw = -3;
CZuq = -4;
CMuw = 5;
CMuq = -6;
CNuv = -7;
CNur = -8;
CY = 0.1;
CZ = -0.2;
CM = -0.3;
CN = -0.4;

q0 = 0;
u0 = 2;
theta0 = -0.001389941910;
w0 = u0 * tan(theta0);
r0 = eval('31.27 * pi / 180');

rho = 1026;
Sref = 0.385;
Lref = 5;
m = 1974.26;
zv = 0;
zg = 3e-2;
q = q0;
W = 9.81 * m;
B = W;
theta = theta0;
w = w0;

CZ0 = -0.01;
CM0 = -0.002;
CY0 = 0;
CN0 = 0;

Iy = 4173.5;
Iz = 4173.5;
Yv = 1845.9;
Zw = 1845.9;
Mq = 3388.7;
Nr = 3388.7;


m_11t = m + auv_param.Mecanic.added_water_matrix(1, 1);
m_33t = m + Zw;
m_55t = Iy + Mq;
m_35 = - m * 0;
m_13 = 0; 
m_15 = 0;%m * zg;

Det_M = m_11t * m_33t * m_55t - m_11t * m_35^2 - m_13^2 * m_55t + 2 * m_13 * m_15 * m_35 - m_15^2 * m_33t;
Det_11 = (m_33t * m_55t - m_35^2) / Det_M;
Det_33 = (m_11t * m_55t - m_15^2) / Det_M;
Det_55 = (m_11t * m_33t - m_13^2) / Det_M;

% State vector:
%       [q          ]
%       [w          ]
% X =   [z          ]
%       [theta      ]
%       [integral(z)]

A_11 = Det_55 * (-m * zg * w + 0.5 * rho * Sref * Lref^2 * CMuq * u0);
A_12 = Det_55 * (-m * zg * q + 0.5 * rho * Sref * CMuw * Lref * u0);
A_13 = 0;
A_14 = - Det_55 * (zg * W - zv * B) * cos(theta);
A_15 = 0;

A_21 = Det_33 * (2 * q * m * zg + m * u0 + 0.5 * rho * Sref * CZuq * Lref * u0);
A_22 = Det_33 * 0.5 * rho * Sref * CZuw * u0;
A_23 = 0;
A_24 = - Det_33 * (W - B) * sin(theta);
A_25 = 0;

A_31 = 0;
A_32 = cos(theta);
A_33 = 0;
A_34 = - u0 * cos(theta) - w * sin(theta);
A_35 = 0;

A_41 = 1;
A_42 = 0;
A_43 = 0;
A_44 = 0;
A_45 = 0;

A_51 = 0;
A_52 = 0;
A_53 = 1;
A_54 = 0;
A_55 = 0;


B_11 = Det_55 * 0.5 * rho * Sref * Lref * CM * u0 * abs(u0);
B_21 = Det_33 * 0.5 * rho * Sref  * CZ * u0 * abs(u0);
B_31 = 0;
B_41 = 0;
B_51 = 0;


% Print for verification
A_verif = [A_22 A_21 A_24;
    A_12 A_11 A_14;
    A_42 A_41 A_44
    ]

B_verif = [B_21 B_11]
