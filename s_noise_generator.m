clear; close all; clc;

T = 1000;
a = 0;
N = 10000;

e = randn(T,1);
x = zeros(T,1);

% Now form the AR(1) series
for t = 1:T-1
   x(t+1) = a*x(t) + e(t+1);
end
plot(x)

f = [-N/2:(N/2)-1]/N;
x = x.^2;
y = fft(x,N);
y = abs(y(N/2:end));
y = y.^2;
y = log10(y);
plot(f(N/2:end),fftshift(y))
xlim([0 0.5])