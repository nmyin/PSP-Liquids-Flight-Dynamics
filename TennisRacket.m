% Defining variables
ix = 0.02; % Moment of Inertia along x axis in kg*m^2
iy = 0.003; % Moment of Inertia along y axis in kg*m^2
iz = 0.027; % Moment of Inertia along z axis in kg*m^2
w = [pi;0.05;0.05]; % Initial angular velocity components in rad/s
q0 = [1;0;0;0]; % Initial quaternion
% Angular acceleration
a = [(iy-iz)*w(2)*w(3)/ix; (iz-ix)*w(1)*w(3)/iy; (ix-iy)*w(1)*w(2)/iz];