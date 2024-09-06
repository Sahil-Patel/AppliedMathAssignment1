function x = newton_solver(fun,derivative,x0)
    x = x0;
    Bthresh = 10e-14; % Threshold for min distance from zero
    Athresh = 10e-14; % Threshold for min window size

    while 1
        last_x = x;
        y = fun(x);
        x = x - y/derivative(x);
        if (abs(x - last_x) < Athresh && abs(y) < Bthresh)
            break
        end
        if (derivative(x) < 10e-10)
            break
        end
        if (y/derivative(x) > 10e6)
            break
        end
    end
end