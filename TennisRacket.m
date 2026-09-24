function TennisRacket()
    % Defining variables
    ix = 0.02; % Moment of Inertia along x axis in kg*m^2
    iy = 0.003; % Moment of Inertia along y axis in kg*m^2
    iz = 0.027; % Moment of Inertia along z axis in kg*m^2
    w0 = [pi;0.05;0.05]; % Initial angular velocity components in rad/s
    q0 = [1;0;0;0]; % Initial quaternion
    x0 = [w0;q0]; % Initial state vector
    tspan = linspace(0,10,100); % Duration of the simulation
    
    [t, x_f] = ode45(@my_ode, tspan, x0); 
    
    RotationsVisualizer(x_f(:, 4:7), t.', 1)
    
    function x_dot = my_ode(t, x)
        w_dot = [(iy-iz)*x(2)*x(3)/ix; (iz-ix)*x(1)*x(3)/iy; (ix-iy)*x(1)*x(2)/iz];
        q_dot = 1/2*[0 -1*x(1) -1*x(2) -1*x(3); x(1) 0 x(3) -1*x(2); x(2) -1*x(3) 0 x(1); x(3) x(2) -1*x(1) 0]*x(4:7);
        x_dot = [w_dot;q_dot];
    end
end
