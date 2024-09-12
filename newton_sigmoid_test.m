clear all
close all
clc

real_zero = newton_solver(@test_function03,@test_derivative03,25)
x_guesses = linspace(0.1,50,1000);
for i = 1:length(x_guesses)
    converged(i) = abs(newton_solver(@test_function03,@test_derivative03,x_guesses(i)) - real_zero )< 0.1;
end

for i = 1:length(x_guesses)
    y(i) = test_function03(x_guesses(i));
end

scatter(x_guesses(converged==1),y(converged==1),'r'); hold on;
scatter(x_guesses(converged==0),y(converged==0),'b')

function f_val = test_function03(x)
    global input_list;
    input_list(:,end+1) = x;
    a = 27.3; b = 2; c = 8.3; d = -3;
    H = exp((x-a)/b);
    dH = H/b;
    L = 1+H;
    dL = dH;
    f_val = c*H./L+d;
end

function dfdx = test_derivative03(x)
    global input_list;
    input_list(:,end+1) = x;
    a = 27.3; b = 2; c = 8.3; d = -3;
    H = exp((x-a)/b);
    dH = H/b;
    L = 1+H;
    dL = dH;
    dfdx = c*(L.*dH-H.*dL)./(L.^2);
end