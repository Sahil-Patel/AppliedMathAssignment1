clear all
close all
clc

test_derivative01 = @(x) 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;

%declare input_list as a global variable
global input_list;
%number of trials we would like to perform
num_iter = 1000;
%list for the left and right guesses that we would like
%to use each trial. These guesses have all been chosen
%so that each trial will converge to the same root
%because the root is somewhere between -5 and 5.
x_left_list = linspace(-10,-5,num_iter);
x_right_list = linspace(5,25,num_iter);
% Initialize lists to store x and index values
bisection_xn = [];
bisection_xn1 = [];
bisection_index = [];
newton_xn = [];
newton_xn1 = [];
newton_index = [];
secant_xn = [];
secant_xn1 = [];
secant_index = [];

%Loop for bisection solver
for n = 1:num_iter
    %pull out the left and right guess for the trial
    x_left = x_left_list(n);
    x_right = x_right_list(n);
    %clear the input_list global variable
    input_list = [];
    %run the bisection solver
    root_accurate = bisection_solver(@test_function01,x_left,x_right);
    % Store the test data
    bisection_xn = [bisection_xn,input_list(1:end-1)];
    bisection_xn1 = [bisection_xn1,input_list(2:end)];
    bisection_index = [bisection_index,1:length(input_list)-1];
end

% Loop newton solver
for n = 1:num_iter
    % pull out the left and right guess for the trial
    x_guess = x_left_list(n);
    % clear the input_list global variable
    input_list = [];
    % run the newton solver
    newton_solver(@test_function01,test_derivative01,x_guess);
    % Store the test data
    newton_xn = [newton_xn,input_list(1:end-1)];
    newton_xn1 = [newton_xn1,input_list(2:end)];
    newton_index = [newton_index,1:length(input_list)-1];
end

%Loop for secant solver
for n = 1:num_iter
    %pull out the left and right guess for the trial
    x_left = x_left_list(n);
    x_right = x_right_list(n);
    %clear the input_list global variable
    input_list = [];
    %run the bisection solver
    secant_solver(@test_function01,x_left,x_right);
    % Store the test data
    secant_xn = [secant_xn,input_list(1:end-1)];
    secant_xn1 = [secant_xn1,input_list(2:end)];
    secant_index = [secant_index,1:length(input_list)-1];
end

% Generate error lists
bisection_err_xn = abs(bisection_xn - root_accurate);
bisection_err_xn1 = abs(bisection_xn1 - root_accurate);

newton_err_xn = abs(newton_xn - root_accurate);
newton_err_xn1 = abs(newton_xn1 - root_accurate);

secant_err_xn = abs(secant_xn - root_accurate);
secant_err_xn1 = abs(secant_xn1 - root_accurate);

loglog(bisection_err_xn,bisection_err_xn1,'ro','markerfacecolor','r','markersize',1);
title('Bisection')
figure()
loglog(newton_err_xn,newton_err_xn1,'ro','markerfacecolor','g','markersize',1);
title('Newton')
figure()
loglog(secant_err_xn,secant_err_xn1,'ro','markerfacecolor','g','markersize',1);
title('Secant')


function output = test_function01(x)
    global input_list;

    %append the current input to input_list
    %formatted so this works even if x is a column vector instead of a scalar input_list(:,end+1) = x;
    input_list(:,end+1) = x;

    %perform the rest of the computation to generate output %I just put in a quadratic function as an example output = (x-3).*(x-7);
    output = (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
end

