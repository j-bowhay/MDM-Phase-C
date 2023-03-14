function [value, isTerminal, direction] = ground_event(t, y)
    % Halt when the ball reaches xaxis ie. y = 0
    value = y(3);
    % End integration
    isTerminal = 1;
    direction = 0; 
end

