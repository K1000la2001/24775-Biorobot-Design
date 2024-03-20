%% Homework 6 Code: Actuators and Power Systems
%  Camila Fernandez - 03/20/2024
%  https://github.com/K1000la2001/24775-Biorobot-Design

clc
clear all
close all

pivoting = true; % same torque for claw tendons
pulling = true; % same torque for finger tendons
scanning = true;


%% Pivoting
if pivoting
    % one degree of motion --> theta
    m = [0:1:5];        % robot mass: kg
    m_sub = [0:.1:5];   % robot mass: kg
    theta_dd = 0.015 ;  % rotational acceleration: rad/s^2
    li = 0.04;          % claw length: m --> 4cm
    u = .42;            % static friction coefficient
    g = 9.8;            % gravitational acceleration
    F_fric = u*m_sub*g; % Friction
    p = pi;
    
    figure
    Torque_sub = (theta_dd * (m_sub*li^2)) + F_fric*li;
    plot(m_sub, Torque_sub);
    xlabel("Mass (kg)")
    ylabel("Torque (Nm)")
    title("Torque Required According to Robot Mass for Pivoting")
    
    F_fric = u*m*g;
    Torque = (theta_dd * (m*li^2) + F_fric*li);
    current = [0:.1:10];
    figure
    labels = [];
    for i = Torque
        K_t = i./current;
        plot(current, K_t);
        labels = [labels, "Torque = " + string(i)]
        hold on
    end
    xlabel("Current (A)")
    ylabel("Torque Constant (Nm/A)")
    title("Pivoting Torque Constant vs Current")
    legend(labels)
end

%% Pulling
if pulling
    % one degree of motion --> q
    m_arm = .5;         % arm mass: kg
    m = [0:1:5];        % robot mass: kg
    m_sub = [0:.1:5];   % robot mass: kg
    l = .5;             % arm length: m
    q_dd = 0.01;        % arm expansion acceleration: m/s^2
    li = 0.04;          % initial arm length: m
    q = [0:.1:0.5];     % arm length: m
    u = .42;            % static friction coefficient
    g = 9.8;            % gravitational acceleration
    F_fric = u*m_sub*g; % Friction
    r = .01;            % motor pulley radius: m --> 0.5cm
    
    figure
    Torque_sub = r .* ((m_sub.*q_dd) + F_fric);
    plot(m_sub, Torque_sub);
    xlabel("Mass (kg)")
    ylabel("Torque (Nm)")
    title("Torque Required According to Robot Mass for Pulling")
    

    F_fric = u*m*g;
    Torque = r .* ((m.*q_dd) + F_fric);
    current = [0:.1:10];
    figure
    labels = [];
    for i = Torque
        K_t = i./current;
        plot(current, K_t);
        labels = [labels, "Torque = " + string(i)]
        hold on
    end
    xlabel("Current (A)")
    ylabel("Torque Constant (Nm/A)")
    title("Pulling Torque Constant vs Current")
    legend(labels)

end

%% Sweeping Rotation
if scanning
    m_arm = .5;         % arm mass: kg
    m_finger = .05;     % finger mass: kg
    l_arm = [.04:.1:.5];% arm length: m
    theta_dd = .015;    % rotational acceleration: rad/s^2

    Torque = ((1/3 .* m_arm .* l_arm.^2) + (m_finger .* l_arm.^2)) .* theta_dd;
    figure
    plot(l_arm, Torque)
    xlabel("Arm Length (m)")
    ylabel("Torque (Nm)")
    title("Torque Required According to Arm Length for Scanning")

    current = [0:.1:10];
    figure
    labels = [];
    for i = l_arm
        Torque = ((1/3 .* m_arm .* l_arm.^2) + (m_finger .* l_arm.^2)) .* theta_dd;
        K_t = i./current;
        plot(current, K_t);
        labels = [labels, "Torque = " + string(Torque)]
        hold on
    end
    xlabel("Current (A)")
    ylabel("Torque Constant (Nm/A)")
    title("Scanning Torque Constant vs Current")
    legend(labels)

end










