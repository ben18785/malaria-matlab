clear; close all; clc; close all hidden;

v_chi = linspace(0.5,5,10);
v_eta = linspace(0.5,5,10);

T = 5000; N = 5*T; dt = T/N;

mu = 0;
k = 1;

m_heat = zeros(length(v_chi),length(v_eta));

for i = 1:length(v_chi)
    i
    for j = 1:length(v_eta)
        
        X = zeros(1,N);
        chi = v_chi(i);
        
        eta = v_eta(j);

        for t = 1:N-1
            dW = sqrt(dt)*randn();
            X(t+1) = X(t) + chi*(mu - X(t))*dt + eta*dW;
        end

        Z = exp(X);
        Z = Z/exp(mu + eta^2/(4*chi));

        [pxx,f] = periodogram(Z,'onesided');
    
        logf = log10(f(2:end));
        logpxx = log(pxx(2:end));
        v_P = polyfit(logf,logpxx,1);
        c_beta = -1*v_P(1);
        m_heat(i,j) = c_beta;
        
        k = k + 1;
    end
end


hmap = HeatMap(m_heat,'RowLabels',v_chi,'ColumnLabels',v_eta);
addYLabel(hmap,'Chi')
addXLabel(hmap,'Eta')

% save('m_heat_beta','m_heat')

