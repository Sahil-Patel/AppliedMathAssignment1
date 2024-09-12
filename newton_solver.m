function x = newton_solver(fun,derivative,x0)
    x = x0;
    Bthresh = 1e-14; % Threshold for min distance from zero
    Athresh = 1e-14; % Threshold for min window size

    counter = 0;
    while counter < 100
        last_x = x;
        y = fun(x);
        x = x - y/derivative(x);
        if (abs(x - last_x) < Athresh && abs(y) < Bthresh)
            break
        end
        if (derivative(x) < 1e-10)
            break
        end
        if (y/derivative(x) > 10e6)
            break
        end
        counter = counter + 1;
    end
end