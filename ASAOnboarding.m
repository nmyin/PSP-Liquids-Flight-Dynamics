%% Physical Constants
mu_E = 398600.4415; % [km3 / s2]
R_E = 6378.1363; % [km]

%% Orbit initial conditions
a = 2 * R_E;
r0 = [400 + R_E; 0; 0];
v0 = [0; sqrt(mu_E * (2 / norm(r0) - 1 / a)); 0]; % Vis viva equation
x0 = [r0; v0];
tf = 60*60*24*360; % [s] 1 day

function [xdot] = gravity(x, mu)
    rvec = x(1:3);
    vvec = x(4:6);
    r = norm(rvec); % get magnitude of position vector
    rdot = vvec;
    vdot = -mu / r ^ 3 * rvec;
    xdot = [rdot; vdot];
end

opts = odeset('RelTol',1e-12,'AbsTol',1e-12);
[t, x] = ode45(@(t, x) gravity(x, mu_E), [0, tf], x0, opts);

earthy(1, "Earth", 0.5, [0;0;0]); hold on
plot_cartesian_orbit(x / R_E, "r", 1, 1); hold off
xlabel("X [R_{Earth}]")
ylabel("Y [R_{Earth}]")
zlabel("Z [R_{Earth}]")
title("Relative 2 Body Orbit Around Earth")
axis equal