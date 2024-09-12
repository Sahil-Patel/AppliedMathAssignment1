clear all
close all
clc
%set the oval hyper-parameters
egg_params = struct();
egg_params.a = 3; egg_params.b = 2; egg_params.c = .15;
%specify the position and orientation of the egg
x0 = 5; y0 = 5; theta = 0;
%set up the axis
hold on; axis equal; axis square
axis([0,10,0,10])
%plot the origin of the egg frame
plot(x0,y0,'ro','markerfacecolor','r');
%compute the perimeter of the egg
[V_list, G_list] = egg_func(linspace(0,1,100),x0,y0,theta,egg_params);
%plot the perimeter of the egg
plot(V_list(1,:),V_list(2,:),'k'); hold on

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

for egg_axis = 1:2
    for i = 1:2
        s_bound = zeros(i,egg_axis);
        [V,G] = egg_func(s_bound,x0,y0,theta,egg_params);
        bounds(i,egg_axis) = V(egg_axis);
    end
end

for i=1:2
    xline(bounds(i,1));
    yline(bounds(i,2));
end

grad_wrapper = @(s) egg_grad(s,x0,y0,theta,egg_params,2);
x_grad_samples = grad_wrapper(linspace(0,1,100));
figure()
plot(linspace(0,1,100),x_grad_samples); hold on
scatter(zeros(:,2),0)

% axis = 1 for x and 2 for y
function g_out = egg_grad(s,x0,y0,theta,egg_params,egg_axis)
    [V,G] = egg_func(s,x0,y0,theta,egg_params);
    g_out = G(egg_axis,:);
end





