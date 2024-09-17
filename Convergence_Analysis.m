%Example template for analysis function
%INPUTS:
%solver_flag: an integer from 1-4 indicating which solver to use
% 1->Bisection 2-> Newton 3->Secant 4->fzero
%fun: the mathematical function that we are using the
% solver to compute the root of
%x_guess0: the initial guess used to compute x_root
%guess_list1: a list of initial guesses for each trial
%guess_list2: a second list of initial guesses for each trial
% if guess_list2 is not needed, then set to zero in input
%filter_list: a list of constants used to filter the collected data
% filter_list = [x_lower, x_upper, x+1_lower, x+1_upper, first_iter]
function convergence_analysis(solver_flag, fun, derivative, root_accurate, guess_list1, guess_list2, filter_list)

    %declare input_list as a global variable
    global input_list;
    %number of trials we would like to perform
    xn = [];
    xn1 = [];
    index = [];

    for n = 1:length(guess_list1)
        %pull out the left and right guess for the trial
        x_0 = guess_list1(n);
        if solver_flag == 1 || solver_flag == 3
            x_1 = guess_list2(n);
        end
        %clear the input_list global variable
        input_list = [];
        %run the bisection solver
        if solver_flag == 1
            [~,bad_guesses] = bisection_solver(fun,x_0,x_1);
            input_list = bad_guesses;
        elseif solver_flag == 2
            newton_solver(fun, derivative, x_0);
        elseif solver_flag == 3
            secant_solver(fun, x_0, x_1);
        elseif solver_flag == 4
            fzero(fun, x_0);
        else 
            error("invalid solver flag");
        end
        % Store the test data
        xn = [xn,input_list(1:end-1)];
        xn1 = [xn1,input_list(2:end)];
        index = [index,1:length(input_list)-1];
    end

    err_xn = abs(xn - root_accurate);
    err_xn1 = abs(xn1 - root_accurate);

    figure()
    loglog(err_xn,err_xn1,'ro','markerfacecolor','r','markersize',1); hold on
    
    regression_points = err_xn >= filter_list(1) & err_xn <= filter_list(2) & err_xn1 >= filter_list(3) & err_xn1 <= filter_list(4) & index > filter_list(5);
    err_xn_regression = err_xn(regression_points);
    err_xn1_regression = err_xn1(regression_points);

    loglog(err_xn_regression, err_xn1_regression, 'bo','markerfacecolor','b','markersize',1)
    xlabel("Error of n ")
    ylabel("Error of n +1 ")
  
    if solver_flag == 1
        title("Bisection")
    elseif solver_flag == 2
        title("Newton")
    elseif solver_flag == 3
        title("Secant")
    elseif solver_flag == 4
        title("Fzero")
    end

    Y = log(err_xn1_regression)';
    X1 = log(err_xn_regression)';
    X2 = ones(length(X1), 1);

    coeff_vec = regress(Y, [X1, X2]);

    p = coeff_vec(1)
    k = exp(coeff_vec(2))

    fit_line_x =10.^[-16:0.01:1];

    fit_line_y =k*fit_line_x.^p;

    loglog(fit_line_x, fit_line_y, 'k-', 'LineWidth',2);

    xlim([1e-16,max(xn)])
    ylim([1e-16,max(xn1)])

    text(1e-5,1e-15,"k = " + k + "  p = " + p)

end
