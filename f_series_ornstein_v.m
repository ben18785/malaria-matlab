function v_Z = f_series_ornstein_v(T,N,chi,eta)
% A function which returns the mean and variance of an exponential orstein
% process with parameters chi and eta, run for T periods

    N = 5000; dt = T/N;
    P = zeros(1,N);
    P(1) = 1;
    X = zeros(1,N);
    mu = 0;
    
    for t = 1:N-1
        dW = sqrt(dt)*randn();
        X(t+1) = X(t) + chi*(mu - X(t))*dt + eta*dW;
        P(t+1) = P(t) + (chi*(mu - log(P(t))) + 0.5*(eta^2))*P(t)*dt + eta*P(t)*dW;
    end

    v_Z = exp(X)/exp(mu + eta^2/(4*chi));