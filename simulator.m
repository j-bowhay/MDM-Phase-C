clear all

clay_x = 0;
clay_y = 0;
clay_launch_angle = 0.5;
clay_launch_speed = 15.6;
clay_mass = 0.105; % 105g weight
clay_Cd = 5.07; % drag coefficient
clay_Cd_alpha = 0.077; % angle dependant drag coefficient
clay_A = 0.0095; % clay area size
rho = 1.184; % air density
clay_C_l_0 = 1.17; % lift coefficient
clay_C_l_alpha = 0.28; % angle dependant lift coefficient


shot_x = 5;
shot_y = 30;
shot_theta = -pi/4;
shot_phi = pi/3;
shot_launch_speed = 3;

options = odeset("Events", @ground_event);

[t_clay, y_clay] = ode45(@(t, y) clay_rhs(t, y, clay_mass, clay_A, rho, clay_Cd, clay_Cd_alpha, clay_C_l_0, clay_C_l_alpha, clay_launch_angle), [0, 100], ...
    [0, 0, 0, clay_launch_speed*cos(clay_launch_angle), 0, clay_launch_speed*sin(clay_launch_angle)]', options);

[t_shot, y_shot] = ode45(@shot_rhs, [0, 100], [shot_x, shot_y, 0,...
    shot_launch_speed*cos(shot_theta)*sin(shot_phi),...
    shot_launch_speed*sin(shot_theta)*sin(shot_phi),...
    shot_launch_speed*cos(shot_phi)]', options);


clf;
plot3(y_clay(:,1),y_clay(:,2),y_clay(:,3), 'DisplayName','Clay');
hold on;
plot3(y_shot(:,1),y_shot(:,2),y_shot(:,3), 'DisplayName','Shot');
legend()
