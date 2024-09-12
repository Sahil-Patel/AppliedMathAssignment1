%Bisection function

function guess = bisection_solver(fun,x_left,x_right)
    
    y_left = fun(x_left);
    y_right = fun(x_right);
    if y_left * y_right > 0
        error('Interval may not contain a zero. Bounds must be of opposite signs.')
    end

    guess = (x_left + x_right)/2;
    Bthresh = 1e-14; % Threshold for min distance from zero
    Athresh = 1e-14; % Threshold for min window size
    
    while (abs(x_right - x_left) > Athresh && abs(fun(guess)) > Bthresh)
        y_guess = fun(guess);
        if y_left * y_guess > 0 % If the signs match (and neither number is zero)
            x_left = guess; % The zero must be in the right half
            y_left = y_guess;
        else
            x_right = guess; % The zero must be in the left half (including the left bound)
            y_right = y_guess;
        end
        guess = (x_left + x_right)/2;
    end
end