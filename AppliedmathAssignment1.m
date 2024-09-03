%Definition of the test function and its derivative
clear all
close all
test_func01 = @(x) (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
test_derivative01 = @(x) 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;
bisection_solver(test_func01, 30, 40)
xline()
plot ((-11:0.1:40),test_func01(-11:0.1:40))
hold on 
xline(test_func01)
xlabel("x")
ylabel("f(x)")
