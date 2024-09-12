clear all
close all
clc
%set the oval hyper-parameters
egg_params = struct();
egg_params.a = 3; egg_params.b = 2; egg_params.c = .15;
%specify the position and orientation of the egg
x0 = 5; y0 = 5; theta = pi/6;

bounds = egg_bounds(x0,y0,theta,egg_params);
bounds = [bounds(:,1,1), bounds(:,2,2)];

figure()
%set up the axis
hold on; axis equal; axis square
% axis([0,10,0,10])
%plot the origin of the egg frame
plot(x0,y0,'ro','markerfacecolor','r');
%compute the perimeter of the egg
[V_list, G_list] = egg_func(linspace(0,1,100),x0,y0,theta,egg_params);
%plot the perimeter of the egg
plot(V_list(1,:),V_list(2,:),'k'); hold on

rectangle('Position',[bounds(1,:), bounds(2,:)-bounds(1,:)], 'EdgeColor','b')