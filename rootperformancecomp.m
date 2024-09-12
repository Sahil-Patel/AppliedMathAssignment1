function output = test_function(x)
    %declare input_list as a global variable
    global input_list;
    %append the current input to input_list
    %formatted so this works even if x is a column vector instead of a scalar
    input_list(:,end+1) = x;
    %perform the rest of the computation to generate output
    %I just put in a quadratic function as an example
    output = (x-3).*(x-7);
end
function solver(testfunction(x))
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
    %list of estimate at current iteration (x_{n})
    %compiled across all trials
    x_current_list = [];
    %list of estimate at next iteration (x_{n+1})
    %compiled across all trials
    x_next_list = [];
    %keeps track of which iteration (n) in a trial
    %each data point was collected from
    index_list = []
    %loop through each trial
    for n = 1:num_iter
        %pull out the left and right guess for the trial
        x_left = x_left_list(n);
        x_right = x_right_list(n);
        %clear the input_list global variable
        input_list = [];
        %run the bisection solver
        bisection_solver(@example_function,x_left,x_right)
        %at this point, input_list will be populated with the values that
        %the solver called at each iteration.
        %In other words, it is now [x_1,x_2,...x_n-1,x_n]
        %append the collected data to the compilation
        x_current_list = [x_current_list,input_list(1:end-1)];
        x_next_list = [x_next_list,input_list(2:end)];
        index_list = [index_list,1:length(input_list)-1];
    end
    %At this point, x_current_list corresponds to many many
    %measurements of x_{n} across many trials
    %and x_next_list corresponds to many many measurements of
    %the corresponding value of x_{n+1} across many trials
    %this is the data the you want to clean and analaze
    

