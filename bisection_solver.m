%Bisection function

function guess = bisection_solver(fun,x_left,x_right)
%your code here
guess = (x_left + x_right)/2;
lastguess = x_left;
Bthresh = 10e-14;
Athresh = 10e-14;

while (abs(lastguess - guess) > Athresh && abs(fun(guess)) > Bthresh)

    
    if fun(x_left) * fun(guess) > 0

       x_left = guess;

     else 

      x_right = guess;

    end 
   
   lastguess = guess;
   guess = (x_left + x_right)/2;

end
