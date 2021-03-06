clear; close all; clc;

c_T = 100;
c_chi = 0.2;
c_eta = 0.5;
c_N = 5000;

% First generate the path of theta - for example the weather
v_theta = f_series_ornstein_v(c_T,c_N,c_chi,c_eta);
c_dt = c_T/c_N;
v_t = 0:c_dt:c_T-c_dt;
plot(v_t,v_theta)

% Parameters for the simulation of patches
c_sigma = 1;
c_Nmax = 100;
c_P0 = 1;
v_P = zeros(c_Nmax,1);
v_P(1) = c_P0;

% While the count is less than the maximum number of iterations, increment
% the time exponentially
t = 0;
k = 1;
v_time = zeros(c_Nmax,1);

while t < c_T
    
    % Get the values of the series to dictate the time increment
    c_theta = interp1(v_t,v_theta,t);
    c_P = v_P(k);
    
    % Increment the time according to Gillespie
    c_r = rand();
    dt = (1/(c_sigma*(c_theta+c_P)))*log(1/c_r);
    t = t + dt;
    
    % Now calculate the new level of patches
    v_P(k+1) = v_P(k) + c_sigma*(c_theta - v_P(k));
    v_time(k+1) = t;
    
    k = k + 1;
    
end
v_P = remove_zeros(v_P);
v_time = remove_zeros(v_time);
v_time = [0;v_time];

plot(v_time,v_P,'r-')
hold on
plot(v_t,v_theta,'m')
xlabel('Time')
legend('Patches','Theta')