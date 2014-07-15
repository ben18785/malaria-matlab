clear; close all; clc;


T = 100; N = 5000; dt = T/N;
dW = 1+sqrt(dt)*randn(1,N); % increments
W = cumsum(dW); % cumulative sum
plot([0:dt:T],[0,W]) % plot W against t

Z = W.^2;
plot([0:dt:T],[0,Z])
