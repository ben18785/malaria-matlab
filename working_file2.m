clear; close all; clc;

T = 1000;
rho = 0.7;
c = 1;
sigma = 0.1;

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
plot(y)
ylim([0 max(y)])
mean(y)
std(y)
