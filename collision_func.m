%Function that computes the collision time for a thrown egg
%INPUTS:
%traj_fun: a function that describes the [x,y,theta] trajectory
%          of the egg (takes time t as input)
%egg_params: a struct describing the hyperparameters of the oval
%y_ground: height of the ground
%x_wall: position of the wall
%OUTPUTS:
%t_collision: vector contai
function t_collision = collision_func(traj_fun, egg_params, y_ground, x_wall)
    for egg_axis = 1:2
        % Select which axis is being compared, wrap function for use with solves
        func_index = @(A, i, j) A(i,j);
        if egg_axis == 1
            egg_dist = @(t) x_wall - func_index(egg_trajectory_bounds(t, traj_fun, egg_params),2, 1);
        else
            egg_dist = @(t) func_index(egg_trajectory_bounds(t, traj_fun, egg_params),1, 2) - y_ground;
        end
        t_collision(egg_axis) = secant_solver(egg_dist, 1e10,1e10+10);
       
        % Plotting the intersections in the t domain
%         figure()
%         steps = 100;
%         x = linspace(0, 5, steps);
%         for i = 1:steps
%             y(i) = egg_dist(x(i));
%         end
%         plot(x, y); hold on
%         scatter(t_collision(egg_axis),0)

    end
end

function bounds = egg_trajectory_bounds(t,traj_fun,egg_params)
    [x0,y0,theta] = traj_fun(t);
    bounds = egg_bounds(x0,y0,theta,egg_params);
    bounds = [bounds(:,1,1), bounds(:,2,2)];
end