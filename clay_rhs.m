function dydt = clay_rhs(t, y)
%[x,y,z,u,v,w]
% at the momement mass is just hard coded as 1; change this
dydt = [y(4), y(5), y(6), 0, 0, -9.81]';
end

