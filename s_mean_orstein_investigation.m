clear; close all; clc;

vv_theta = [0.2,0.4,0.6,0.8];
cell_col = {'r','g','b','m'}

for kk = 1:4

    N = 10;
    M = 20;
    T = 1000;

    v_theta = linspace(vv_theta(kk),vv_theta(kk),1);
    v_sigma = linspace(0,1,M);

    % Now make a matrix with all the parameter values in it
    m_params = zeros(M,2);

    k = 1;
    for i = 1:1
        for j = 1:M
            m_params(k,:) = [v_theta(i),v_sigma(j)];
            k = k + 1;
        end
    end

    c_len_params = length(m_params);

    % Now run the simulations returning the mean and variance
    m_results = zeros(c_len_params,3);

    for i = 1:c_len_params
        v_zbar = zeros(N,1);
        v_zvar = zeros(N,1);
        for j = 1:N
            [c_zb,c_zv] = f_moments_ornstein_v(T,m_params(i,1),m_params(i,2));
            v_zbar(j) = c_zb;
            v_zvar(j) = c_zv;
        end
        c_zbar = mean(v_zbar);
        c_sd = std(v_zbar);
        m_results(i,:) = [c_zbar,c_zbar+c_sd,c_zbar-c_sd];
    end
%     plot(v_sigma,m_results(:,1),cell_col{kk})
%     hold on

    % Do a box plot
    boxplot(m_results')
    ylim([0 5])
    hold on
end
% legend('0.2','0.4','0.6','0.8')
% ylabel('Mean')
% xlabel('Eta')