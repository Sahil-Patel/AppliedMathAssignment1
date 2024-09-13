clear all
close all
clc

%define location and filename where video will be stored
%written a bit weird to make it fit when viewed in assignment
fname = '/Users/vaughn/Documents/School/Applied Math/egg2.avi';
writerObj = VideoWriter(fname);
open(writerObj);

%set the oval hyper-parameters
egg_params = struct();
egg_params.a = 3; egg_params.b = 2; egg_params.c = .15;

x_wall = 30;
y_ground = 3;

%set up the plotting axis
fig1 = figure(1);
hold on; axis equal; axis square
axis([0,40,0,40])
egg_plot = plot(0,0,'k');

t_collision = collision_func(@egg_trajectory01, egg_params, y_ground, x_wall);

xline(x_wall);
yline(y_ground);

for t = 0:0.01:min(t_collision)
    [x0,y0,theta] = egg_trajectory01(t);
    [V_list, G_list] = egg_func(linspace(0,1,50),x0,y0,theta,egg_params);
    set(egg_plot,'xdata',V_list(1,:),'ydata',V_list(2,:));

    drawnow;
    %capture a frame (what is currently plotted)
    current_frame = getframe(fig1);
    %write the frame to the video
    writeVideo(writerObj,current_frame);
end

hit_floor = t_collision(1) > t_collision(2);
bounds = egg_bounds(x0,y0,theta,egg_params);
if hit_floor
    hit_point = bounds(1,2,:);
else
    hit_point = bounds(2,1,:);
end

scatter(hit_point(1), hit_point(2));
pause(2);

%capture a frame (what is currently plotted)
current_frame = getframe(fig1);
%write the frame to the video
for i = 1:30
    writeVideo(writerObj,current_frame);
end

close(writerObj);

function [x0,y0,theta] = egg_trajectory01(t)
    x0 = 5*t;
    y0 = -6*t.^2 + 20*t + 10;
    theta = 2*t;
end






