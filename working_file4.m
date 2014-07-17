clear; close all; clc;


T = 1000; N = 5000; dt = T/N;
X = zeros(1,N);
theta = 2;
mu = 0;
sigma = 1;

for t = 1:N-1
    dW = sqrt(dt)*randn();
    X(t+1) = X(t) + theta*(mu - X(t))*dt + sigma*dW;
end

Z = exp(X);

% v_parzen = parzenwin(length(X));
[pxx,f] = periodogram(Z,'onesided')
% subplot(1,2,1),plot(0:dt:T-dt,Z)
% subplot(1,2,2),plot(log10(f),log10(pxx))
% xlim([-4,max(f)])
plot(log10(f),log10(pxx))
logf = log10(f);
logpxx = log10(pxx);

plot(logf,logpxx)
P = polyfit(logf,logpxx,1)


