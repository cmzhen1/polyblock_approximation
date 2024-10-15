%% 优化
clear;
global epsilon_max sigma_glo_max; %L gamma xi epsilon_req 
epsilon_max = 0.9;  % 最大误差
L = 1;
gamma = 1;
xi = 1e-4; % 容忍误差
epsilon_req = 1e-2;
k = 0;

% 定义sigma_glo(ε)函数
%sigma_glo = @(epsilon) ((1 / (1 - epsilon)) * (2 * L^2 / (gamma^2 * xi)) * log(1 / epsilon_req));

% 定义 V_hat(ε) 函数，这里作为示例
%V_hat = @(i) 200 * (1 - i);  % 你需要根据实际的定义来替换

CBV = inf;  % 初始化最优目标函数值
e_inital = epsilon_max;
sigma_glo_max = sigma_glo(epsilon_max);
z_inital = 1;
V = [e_inital,z_inital];  % 初始化顶点集

% 定义目标函数 f(ε, z)
f = @(epsilon, z) (sigma_glo_max * V_hat(epsilon)) / z;  % 包含 V_hat(ε) 的目标函数

% 主循环
while true
    k = k + 1;
    
    % 选择使目标函数值最大的顶点 x_k
    f_values = arrayfun(@(row) f(V(row, 1), V(row, 2)), 1:size(V, 1));  % 计算每个顶点的目标函数值
    [~, idx] = max(f_values);  % 找到使目标函数值最大的索引
    x_k = V(idx, :);  % 选出对应的顶点
    CBV = f_values;

    % 计算投影点 x_k_proj
    x_k_proj = project_x(x_k);

    disp(['Iteration ', num2str(k)]);
    disp('Current vertices:');
    disp(V);
    disp('Current best solution:');
    disp(CBV);

    % 如果投影点和当前顶点相同，跳出循环
    if isequal(x_k, x_k_proj)
        CBS_k = x_k;
        CBV = f(x_k(1,1),x_k(1,2));
        break;  % 满足条件，跳出循环
    else
        % 检查投影点是否满足约束 (60)
        f_project=f(x_k_proj(1,1), x_k_proj(1,2));
        if condition(x_k_proj) && (f_project<= CBV)
            CBS_k = x_k_proj;
            CBV = f(x_k_proj(1,1), x_k_proj(1,2));  
        else
            % 如果不满足约束，则使用前一个顶点值
            CBS_k = x_k;  % 继续使用之前的解 
            CBV = f(x_k(1,1),x_k(1,2)); 
        end
         % 剔除旧顶点 x_k
         V(ismember(V, x_k, 'rows'), :) = [];
         V = [V;[CBS_k(1,1), z_inital]; [e_inital, CBS_k(1,2)]]; % 将 投影点对应的新顶点追加到 V
    end    
    % 收敛检查
    if abs(f(CBS_k(1,1),CBS_k(1,2)) - CBV) <= xi
        break;  % Stop if solution converges
    end
end

% Output the optimal solution
fprintf('Optimal solution: epsilon = %.6f, z = %.6f, with cost: CBV = %.6f\n', CBS_k(1,1), CBS_k(1,2), CBV);



% 定义目标函数 f(ε, z)
% function f_val = f(epsilon, z,sigma_glo_max)
%     V_hat_val = V_hat(epsilon);
%     f_val = (sigma_glo_max * V_hat_val) / z;
% end



 

