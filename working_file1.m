clear; close all; clc;

N = 100;
z = zeros(N,1);

for i = 1:N
    T = 1000;
    rho = 0.5;
    c = 0;
    sigma = 1;

    e = randn(T,1);
    x = zeros(T,1);

    % Start at the series' average
    xbar = c/(1-rho);
    x(1) = xbar;

    % Now form the AR(1) series
    for t = 1:T-1
       x(t+1) = c + rho*x(t) + sigma*e(t+1);
    end
    y = x.^2;
    % y = y/max(y);
    % plot(y)
    % ylim([0 1])
    mean(y)
    ybar = (1/(1-rho^2))*(((c^2)/(1-rho))*(1+rho) + sigma^2);
    ybar = (c^2)/((1-rho)^2) + (sigma^2)/(1-rho^2);
    z(i) = mean(y) - ybar;
end
hist(z)
plot(y)
