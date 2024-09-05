%Bisection function

function guess = bisection_solver(fun,x_left,x_right)
    
    if fun(x_left) * fun(x_right) > 0
        error('Interval may not contain a zero. Bounds must be of opposite signs.')
    end

    guess = (x_left + x_right)/2;
    Bthresh = 10e-14; % Threshold for min distance from zero
    Athresh = 10e-14; % Threshold for min window size
    
    while (abs(x_right - x_left) > Athresh && abs(fun(guess)) > Bthresh)
        if fun(x_left) * fun(guess) > 0 % If the signs match (and neither number is zero)
            x_left = guess; % The zero must be in the right half
        else
            x_right = guess; % The zero must be in the left half (including the left bound)
        end
        guess = (x_left + x_right)/2;
    end
end
