clear; close all; clc;

v_chi = [0.1; 2];
v_eta = [0.1; 2];
mu = 0;
k = 1;
for i = 1:2
    for j = 1:2
        T = 10000; N = 10*T; dt = T/N;
        X = zeros(1,N);
        chi = v_chi(i);
        
        eta = v_eta(j);

        for t = 1:N-1
            dW = sqrt(dt)*randn();
            X(t+1) = X(t) + chi*(mu - X(t))*dt + eta*dW;
        end

        Z = exp(X);
        Z = Z/mean(Z);

%         Z = Z - mean(Z); % Standardise mean
%         Z = Z + abs(min(Z));
%         Z = Z/std(Z); % Normalise variance
%         
        subplot(2,2,k),hist(Z,50)
        s_chieta = strcat('chi = ',num2str(v_chi(i)),', ','eta = ', num2str(v_eta(j)));
        title(s_chieta)
        
        k = k + 1;
    end
end
    




