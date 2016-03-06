function [mu, sigma]=mle_normal(Data) %Each Row is one example 
% So if we have N trainign examples there are N rows
N=size(Data,1)
mu=mean(Data);
sigma=(cov(Data)*(N-1))/(N);
%sigma=cov(Data,1);
%Both the sigma's imply the same thing


