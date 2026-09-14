% Defining rocket parameters
thrust = 2000; % Thrust in Newtons (N)
mass = 40; % Mass of rocket in Kilograms (kg)
burn_time = 5; % I have absolutely no idea what this is, but it's in seconds
outer_diameter = 0.1; % Outer diameter of the cylinder in Meters (m)
drag_c = 0.75; % Drag coefficient
v0 = 5; % Initial velocity of cylinder in m/s
angle = 30* pi/180; % Initial angle of launch
velocity = [cos(angle)*v0 sin(angle)*v0];
density = 1.225; % Density of air at sea level in kg/m^3
g = 9.8; % Acceleration due to gravity at ground level in m/s^2
% Drag force on the cylinder in Newtons (N)
drag = 0.5*density*(velocity(1)^2+velocity(2)^2)*drag_c*outer_diameter^2*pi/4;
w = 5; % Angular velocity in rad/s
rotations = 0; % Number of rotations completed in rad
delta_t = 0.1; % Change in time in seconds (so like dt but I can change the value)

% Making the position and velocity vectors
% The coordinates are fixed on the ground
% The angle at which Ft and Fd act on the cylinder depend on the angle of
% the cylinder to the ground, which is always tangent to the cylinder's
% trajectory
trajectory = [];
rotations(end+1) = rotations(end) + w*delta_t;
position = [0 0];
trajectory = [trajectory;position];

position = [position(1)+velocity(1)*delta_t position(2)+velocity(2)*delta_t];
trajectory = [trajectory;position];
acceleration = [cos(atan(velocity(2)/velocity(1)))*(thrust-drag)/mass sin(atan(velocity(2)/velocity(1)))*(thrust-drag-mass*g)/mass];
velocity = [velocity(1)+acceleration(1)*delta_t velocity(2)+acceleration(2)*delta_t];

while position(2)>0
    disp(position(2));
    position = [position(1)+velocity(1)*delta_t position(2)+velocity(2)*delta_t];
    trajectory = [trajectory;position];
    acceleration = [cos(atan(velocity(2)/velocity(1)))*(thrust-drag)/mass sin(atan(velocity(2)/velocity(1)))*(thrust-drag-mass*g)/mass];
    velocity = [velocity(1)+acceleration(1)*delta_t velocity(2)+acceleration(2)*delta_t];
end
RocketAnimation(position, rotations);