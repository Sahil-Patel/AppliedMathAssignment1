function x = newton_solver(fun,derivative,x0)
    x = x0;
    Bthresh = 10e-14; % Threshold for min distance from zero
    Athresh = 10e-14; % Threshold for min window size

    while 1
        last_x = x;
        x = x - fun(x)/derivative(x);
        if (abs(x - last_x) < Athresh && abs(fun(x)) < Bthresh)
            break
        end
    end
end