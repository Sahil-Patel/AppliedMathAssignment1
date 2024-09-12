%Secant function

function guess = secant_solver(fun,x0,x1)
%your code here
y0 = (fun(x0));
y1 = (fun(x1));
Bthresh = 1e-14;
Athresh = 1e-14;

max_iter = 50;
delta_x = 10;

count = 0;
while abs(delta_x) > Athresh && abs(y1) > Bthresh && count<=max_iter
    count = count+1;

    slope = (y0 - y1) / (x0 - x1);


   % checking for same x0 and x1
   if slope == 0 
       break
   end

    % x_0 is the new x0 after y0 is set to zero at the x-axis
    delta_x = - y1 / slope;

    if abs(delta_x) > 1e10
        break
    end

    x_next = x1 + delta_x;
    y_next = fun(x_next);

    x0 = x1;
    y0 = y1;
    x1 = x_next;
    y1 = y_next;

end

guess = x1;