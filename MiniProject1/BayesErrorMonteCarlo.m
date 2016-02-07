function [ e ] = BayesErrorMonteCarlo( n, P1, M1, Sigma1, P2, M2, Sigma2, N )
%Compute Bayes Error using Monte-Carlo method
%Written by J. Zhou
 
% ....Input Parameters
% n --- data dimension
% P1 --- prior probability of class 1
% M1 --- mean of class 1 data
% Sigma1 --- covariance of class 1 data
% p2 --- prior probability of class 2
% M2 --- mean of class 2 data
% Sigma2 --- covariance of class 2 data
% N --- number of samples using in Monte-Carlo
 
%....Output Parameters
% e --- Bayes Error
 
x1 = randn(n,N);
y1 = discFunc(x1, P1, M1, Sigma1, P2, M2, Sigma2, 1); 
e1 = y1/N;
 
 
temp = randn(n,N);
x2 = sqrt(Sigma2)*temp + repmat(M2, 1, N);
y2 = discFunc(x2, P1, M1, Sigma1, P2, M2, Sigma2, 2);
e2 = y2/N;
 
% Bayes Error e
e = P1*e1+P2*e2;
 
 
end