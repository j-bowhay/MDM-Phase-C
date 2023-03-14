clay_x = 0;
clay_y = 0;
clay_theta = 0;
clay_phi = pi/4;
clay_launch_speed = 10;

shot_x = 5;
shot_y = 5;
shot_theta = pi/4;
shot_phi = pi/4;
shot_launch_speed = 10;

options = odeset("Events", @ground_event);

[t_clay, y_clay] = ode45(@clay_rhs, [0, 100], ...
    [clay_x, clay_y, 0,...
    clay_launch_speed*cos(clay_theta)*sin(clay_phi),...
    clay_launch_speed*sin(clay_theta)*sin(clay_phi),...
    clay_launch_speed*cos(clay_phi)]', options);
[t_shot, y_shot] = ode45(@shot_rhs, [0, 100], [shot_x, shot_y, 0,...
    shot_launch_speed*cos(shot_theta)*sin(shot_phi),...
    shot_launch_speed*sin(shot_theta)*sin(shot_phi),...
    shot_launch_speed*cos(shot_phi)]', options);


clf;
plot3(y_clay(:,1),y_clay(:,2),y_clay(:,3), 'DisplayName','Clay');
hold on;
plot3(y_shot(:,1),y_shot(:,2),y_shot(:,3), 'DisplayName','Shot');

legend()