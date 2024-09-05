%Secant function

function guess = secant_solver(fun,x_left,x_right)
%your code here
y_left = (fun(x_left));
y_right = (fun(x_right));
Bthresh = 10e-14;
Athresh = 10e-14;

while (abs(x_left - x_right) > Athresh && abs(fun(y_right)) > Bthresh)

    slope = (y_left - y_right) / (x_left - x_right);

    %% x_0 is the new x_left after y_left is set to zero at the x-axis
    x_0 = x_right - y_right / slope;

   %% checking for same x_left and x_right
   if slope == 0 

       error("same x");
   end
   %% if x_left and x_right have opposite signs then we shift left otherwise shift right
   if fun(x_left) * fun(x_right) > 0
        x_left = x_0;
        y_left = fun(x_left);
    else
        x_right = x_0;
        y_right = fun(x_right);
   end

end

guess = x_0;