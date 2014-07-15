clear; close all; clc;


T = 1000; N = 5000; dt = T/N;
X = zeros(1,N);
theta = 0;
mu = 0;
sigma = 0.5;

for t = 1:N-1
    dW = sqrt(dt)*randn();
    X(t+1) = X(t) + theta*(mu - X(t))*dt + sigma*dW;
end

plot([0:dt:T],[0,X])
Z = exp(X);
plot([0:dt:T],[0,Z])
