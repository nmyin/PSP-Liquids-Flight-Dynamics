clear clc
% Defining rocket parameters
thrust = 2000; % Thrust in Newtons (N)
mass = 40; % Mass of rocket in Kilograms (kg)
burn_time = 5; % Duration that the thrust are on
outer_diameter = 0.1; % Outer diameter of the cylinder in Meters (m)
drag_c = 0.75; % Drag coefficient
v0 = 5; % Initial velocity of cylinder in m/s
angle = pi/4; % Initial angle of launch
velocity = [cos(angle)*v0 sin(angle)*v0];
density = 1.225; % Density of air at sea level in kg/m^3
g = 9.8; % Acceleration due to gravity at ground level in m/s^2
% Drag force on the cylinder in Newtons (N)
drag = 0.5*density*(velocity(1)^2+velocity(2)^2)*drag_c*outer_diameter^2*pi/4;
w = 5; % Angular velocity in rad/s
delta_t = 0.1; % Change in time in seconds (so like dt but I can change the value)
t = 0; % Time spent in flight
apogee = 0;
temp_vy = velocity(2);

% Making the position and velocity vectors
% The coordinates are fixed on the ground
% The angle at which Ft and Fd act on the cylinder depend on the angle of
% the cylinder to the ground, which is always tangent to the cylinder's
% trajectory
rotations = [atan(velocity(2)/velocity(1))];
position = [0 0];
trajectory = [position t sqrt(velocity(1)^2 + velocity(2)^2)];

while burn_time >= 0
    position = [position(1)+velocity(1)*delta_t position(2)+velocity(2)*delta_t];
    rotations = [rotations; atan(velocity(2)/velocity(1))];
    drag = 0.5*density*(velocity(1)^2+velocity(2)^2)*drag_c*outer_diameter^2*pi/4;
    acceleration = [cos(atan(velocity(2)/velocity(1)))*(thrust-drag)/mass (sin(atan(velocity(2)/velocity(1)))*(thrust-drag)/mass)-g];
    temp_vy = velocity(2);
    velocity = [velocity(1)+acceleration(1)*delta_t velocity(2)+acceleration(2)*delta_t];
    if (velocity(2)<=0 && temp_vy > 0)
        apogee = position(2);
    end
    burn_time = burn_time - delta_t;
    t = t + delta_t;
    trajectory = [trajectory; position t sqrt(velocity(1)^2 + velocity(2)^2)];
end
while position(2) >= 0
    position = [position(1)+velocity(1)*delta_t position(2)+velocity(2)*delta_t];
    rotations = [rotations; atan(velocity(2)/velocity(1))];
    drag = 0.5*density*(velocity(1)^2+velocity(2)^2)*drag_c*outer_diameter^2*pi/4;
    acceleration = [cos(atan(velocity(2)/velocity(1)))*(-drag)/mass (sin(atan(velocity(2)/velocity(1)))*(-drag)/mass)-g];
    temp_vy = velocity(2);
    velocity = [velocity(1)+acceleration(1)*delta_t velocity(2)+acceleration(2)*delta_t];
    if (velocity(2)<=0 && temp_vy > 0)
        apogee = position(2);
    end
    t = t + delta_t;
    trajectory = [trajectory; position t sqrt(velocity(1)^2 + velocity(2)^2)];
end

fprintf('The apogee of the rocket is %.2f m.\n', apogee);
RocketAnimation(trajectory, rotations); % Rocket Animation

% Plotting the trajectory of the rocket
figure(3);
plot(trajectory(:,1), trajectory(:,2));
xlabel('Range (m)');
ylabel('Height (m)');
title('Trajectory of the Rocket');

% Plotting the horizontal and vertical velocities of the rocket
figure(4);
plot(trajectory(:,3), trajectory(:,4));
xlabel('Time (s)');
ylabel('Velocity (m/s)');
title('Velocity of the Rocket over the Trajectory');
