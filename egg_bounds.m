% bounds is structured as follows:
% [x_low y_low;
% x_high y_high]

function [bounds] = egg_bounds(x0, y0, theta, egg_params)
    % look for zeros using 3 ranges to make sure both are captured
    for egg_axis = 1:2
        grad_wrapper = @(s) egg_grad(s,x0,y0,theta,egg_params,egg_axis);
        for i = 1:3
            [all_zeros(i,egg_axis),success] = secant_solver(grad_wrapper, (i-1)/3, (i-1)/3 + 0.1);
            if ~success
                all_zeros(i,egg_axis) = secant_solver(grad_wrapper, (i-1)/3, (i-1)/3 + 0.3);
            end
            all_zeros(i,egg_axis) = mod(all_zeros(i,egg_axis),1);
        end
        true_zeros(1,egg_axis) = min(all_zeros(:,egg_axis));
        true_zeros(2,egg_axis) = max(all_zeros(:,egg_axis));
    end
    
    % Convert s values of zeros to x and y bounds.
    bounds = zeros(2,2,2);
    for egg_axis = 1:2
        for i = 1:2
            s_bound = true_zeros(i,egg_axis);
            [V,~] = egg_func(s_bound,x0,y0,theta,egg_params);
            bounds(i,egg_axis,:) = V;
        end
    end
    % Sort the bounds so the lower and upper are in their correct places.
    bounds_sorted = bounds;
    for i = 1:2
        if bounds(1,i,i) > bounds(2,i,i)
            bounds_sorted(1,i,:) = bounds(2,i,:);
            bounds_sorted(2,i,:) = bounds(1,i,:);
        end
    end
    bounds = bounds_sorted;
   
% Shit to test special case debugging below
%     figure()
%     grad_wrapper = @(s) egg_grad(s,x0,y0,theta,egg_params,2);
%     test = linspace(0,1,100);
%     plot(test, grad_wrapper(test)); hold on
%     scatter(all_zeros(:,2),0)
%     all_zeros(:,2)
%     grad_wrapper(all_zeros(:,2)')
end

% axis = 1 for x and 2 for y
function g_out = egg_grad(s,x0,y0,theta,egg_params,egg_axis)
    [~,G] = egg_func(s,x0,y0,theta,egg_params);
    g_out = G(egg_axis,:);
end

