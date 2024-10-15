function sigma = sigma_glo(epsilon)
    %global L gamma xi epsilon_req;
    sigma = (1 / (1 - epsilon)) ;%* (2 * L^2 / (gamma^2 * xi)) * log(1 / epsilon_req);
end