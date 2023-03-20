function dydt = clay_rhs(t, y, M, A, rho, Cd_0, Cd_alpha, Cl_0, Cl_alpha, theta)
%[x,y,z,u,v,w] note v should always be zero then rotate afterwards
alpha = abs(theta - atan2(y(6),y(4))); % angle of attack
v = norm(y(4:end));

D = 0.5 * rho * v^2 * (Cd_0 + alpha^2 * Cd_alpha) * A; % drag
L = 0.5 * rho * v^2 * (Cl_0 + alpha * Cl_alpha) * A; % lift

dydt = [y(4), y(5), y(6),...
    -(D/M)*cos(alpha-theta) - (L/M)*sin(alpha-theta), ...
    0, ...
    -(D/M)*sin(alpha-theta) - (L/M)*cos(alpha-theta) - 9.81]';
end

