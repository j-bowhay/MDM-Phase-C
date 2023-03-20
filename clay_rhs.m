function dydt = clay_rhs(t, y, m, Cd, Cl, A, rho, theta, phi)
%[x,y,z,u,v,w]
v = sqrt(y(4)^2+y(5)^2+y(6)^2);
dragForce = 0.5 * rho * v^2 * Cd * A;
liftForce = 0.5 * rho * v^2 * Cl * A;
dydt = [y(4), y(5), y(6), -dragForce*cos(theta), -dragForce*sin(theta), -9.81*m-dragForce*cos(phi)]';
end

