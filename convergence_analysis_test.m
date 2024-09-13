clear all
close all
clc
num_iter = 1000;
test_derivative01 = @(x) 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;
root_accurate = newton_solver(@test_function01,test_derivative01,0);

Convergence_Analysis(1,@test_function01,test_derivative01,root_accurate,linspace(-10,-5,num_iter), linspace(5,25,num_iter), [1e-12, 1e-3, 1e-12, 1e-3, 3])
Convergence_Analysis(2,@test_function01,test_derivative01,root_accurate,linspace(-3,3,num_iter), 0, [1e-6, 1e-1, 1e-12, 1e-4, 3])
Convergence_Analysis(3,@test_function01,test_derivative01,root_accurate,linspace(-5,5, num_iter), linspace(-5,5, num_iter)+1, [1e-8, 1e-1, 1e-12, 1e-4, 3])
Convergence_Analysis(4,@test_function01,test_derivative01,root_accurate,linspace(-3,3,num_iter), 0, [1e-6, 1e-1, 1e-12, 1e-4, 3])

[dfdx,d2fdx2] = approximate_derivative(@test_function01,fzero(@test_function01,3));
newton_k = abs(1/2*d2fdx2/dfdx)


function output = test_function01(x)
    global input_list;

    %append the current input to input_list
    %formatted so this works even if x is a column vector instead of a scalar input_list(:,end+1) = x;
    input_list(:,end+1) = x;

    %perform the rest of the computation to generate output %I just put in a quadratic function as an example output = (x-3).*(x-7);
    output = (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
end


function [dfdx, d2fdx2] = approximate_derivative(fun,x)
    delta_x = 1e-6;
    f_left = fun(x-delta_x);
    f_0 = fun(x);
    f_right = fun(x+delta_x);

    dfdx = (f_right-f_left)/(2*delta_x);
    d2fdx2 = (f_right-2*f_0+f_left)/(delta_x^2);
end
