 function [k_proj] = project_x(k)
    % Input:
    % x_k - vector to be projected
    % proj_epsilon- precision parameter

    % Initialize bisection bounds
    mu_min = 0;
    mu_max = 1;
    proj_epsilon = 1e-2;   
    sigma_glo_max =  10;
    sigma_glo = @(x) 1/(1-x);
    bound_k = inf;

    % Bisection loop
    while abs(bound_k - sigma_glo_max) > proj_epsilon
        mu = (mu_max + mu_min) / 2;  % Calculate the midpoint
       
        % Project v with current mu
        k_proj = mu * k;
        bound_k = k_proj(1,1)*sigma_glo(k_proj(1,2)) ;
        % Check if projected vector is within the feasible region

        if bound_k <= sigma_glo_max 
            mu_min = mu;  % Update lower bound if condition is satisfied
        else
            mu_max = mu;  % Update upper bound if condition is not satisfied
        end
    end
 end 
