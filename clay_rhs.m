function dydt = clay_rhs(t, y, M, A, rho, Cd, Cl, theta)
%[x,y,z,u,v,w] note v should always be zero then rotate afterwards
alpha = atan2(y(6),y(4));
v = norm(y(4:end));

D = 0.5 * rho * v^2 * Cd * A; % drag
L = 0.5 * rho * v^2 * Cl * A; % lift

dydt = [y(4), y(5), y(6),...
    -(D/M)*cos(alpha-theta) - (L/M)*sin(alpha-theta), ...
    0, ...
    -(D/M)*sin(alpha-theta) - (L/M)*cos(alpha-theta) - 9.81]';
end

