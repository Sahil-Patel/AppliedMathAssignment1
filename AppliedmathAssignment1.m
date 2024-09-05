%Definition of the test function and its derivative
clear all
close all
clc

test_func01 = @(x) (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
test_derivative01 = @(x) 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;

zero = bisection_solver(test_func01, 30, 40);
sample_range = -11:0.1:40;
plot(sample_range,test_func01(sample_range)); hold on
scatter(zero,0);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
xlabel("x")
ylabel("f(x)")
title('Bisection')
ylim([-50 100])

zero_newton = newton_solver(test_func01, test_derivative01, 35);
scatter(zero_newton, 0);

