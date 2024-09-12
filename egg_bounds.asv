% bounds is structured as follows:
% [x_low y_low;
% x_high y_high]

function bounds = egg_bounds(x0, y0, theta, egg_params)
    % look for zeros using 3 ranges to make sure both are captured
    for egg_axis = 1:2
        grad_wrapper = @(s) egg_grad(s,x0,y0,theta,egg_params,egg_axis);
        for i = 1:3
            all_zeros(i,egg_axis) = secant_solver(grad_wrapper, (i-1)/3, i/3);
            all_zeros(i,egg_axis) = mod(all_zeros(i,egg_axis),1);
        end
        zeros(1,egg_axis) = min(all_zeros(:,egg_axis));
        zeros(2,egg_axis) = max(all_zeros(:,egg_axis));
    end
    
    % Convert s values of zeros to x and y bounds.
    bounds = zeros(2,2);
    for egg_axis = 1:2
        for i = 1:2
            s_bound = zeros(i,egg_axis);
            [V,~] = egg_func(s_bound,x0,y0,theta,egg_params);
            bounds(i,egg_axis) = V(egg_axis);
        end
    end
end

% axis = 1 for x and 2 for y
function g_out = egg_grad(s,x0,y0,theta,egg_params,egg_axis)
    [~,G] = egg_func(s,x0,y0,theta,egg_params);
    g_out = G(egg_axis,:);
end