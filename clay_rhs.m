function dydt = clay_rhs(t, y, m, A, rho, Cd, Cl)
%[x,y,z,u,v,w]
alpha = atan(y(5)/ y(4));
beta = atan(y(6)/ sqrt(y(4)^2 + y(5)^2));
v = sqrt(y(4)^2+y(5)^2+y(6)^2);

dragForce = 0.5 * rho * v^2 * Cd * A;
liftForce = 0.5 * rho * v^2 * Cl * A;

dydt = [y(4), y(5), y(6), -dragForce*cos(alpha), -dragForce*sin(alpha), -9.81*m+liftForce*sin(beta)]';
end

