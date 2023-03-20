clear all

clay_x = 0;
clay_y = 0;
clay_theta = 0;
clay_phi = pi/4;
clay_launch_speed = 15.6;
clay_mass = 0.105; % 105g weight
clay_Cd = 0.2; % drag coefficient
clay_A = 0.0095; % clay area size
rho = 1.184; % air density
clay_CL = 0.1; % lift coefficient

shot_x = 5;
shot_y = 30;
shot_theta = -pi/4;
shot_phi = pi/3;
shot_launch_speed = 300;

options = odeset("Events", @ground_event);

[t_clay, y_clay] = ode45(@(t, y) clay_rhs(t, y, clay_mass, clay_A, rho, clay_Cd, clay_CL), [0, 100], ...
    [clay_x, clay_y, 0,...
    clay_launch_speed*cos(clay_theta)*sin(clay_phi),...
    clay_launch_speed*sin(clay_theta)*sin(clay_phi),...
    clay_launch_speed*cos(clay_phi)]', options);
[t_shot, y_shot] = ode45(@shot_rhs, [0, 100], [shot_x, shot_y, 0,...
    shot_launch_speed*cos(shot_theta)*sin(shot_phi),...
    shot_launch_speed*sin(shot_theta)*sin(shot_phi),...
    shot_launch_speed*cos(shot_phi)]', options);


clf;
figure
plot3(y_clay(:,1),y_clay(:,2),y_clay(:,3), 'DisplayName','Clay');
hold on;
plot3(y_shot(:,1),y_shot(:,2),y_shot(:,3), 'DisplayName','Shot');
xlim([min(y_clay(:,1)) max(y_clay(:,1))])
ylim([0 50])
zlim([min(y_clay(:,3)) max(y_clay(:,3))])

legend()
