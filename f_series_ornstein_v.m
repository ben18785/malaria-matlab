function v_Z = f_series_ornstein_v(T,N,theta,sigma)
% A function which returns the mean and variance of an exponential orstein
% process with parameters theta and sigma, run for T periods

    N = 5000; dt = T/N;
    P = zeros(1,N);
    P(1) = 1;
    X = zeros(1,N);
    mu = 0;
    
    for t = 1:N-1
        dW = sqrt(dt)*randn();
        X(t+1) = X(t) + theta*(mu - X(t))*dt + sigma*dW;
        P(t+1) = P(t) + (theta*(mu - log(P(t))) + 0.5*(sigma^2))*P(t)*dt + sigma*P(t)*dW;
    end

    v_Z = exp(X);