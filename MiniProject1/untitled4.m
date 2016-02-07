%% ECE662 
% This code tests BayesErrorMonteCarlo.m using a data set with known
% Bayes Error
% J. Zhou
 
close all;
clear all;
 
% test data using Data I-^ ; Fukunaga page 45
n = 8;   %data dimension
 
P1 = 0.5; % prior probability for class 1
M1 = zeros(n, 1);  %mean of class 1 data
Sigma1 = eye(n,n);  %covariance of class 1 data
 
P2 = 0.5; % prior probability for class 2
M2 = [3.86, 3.10, 0.84, 0.84, 1.64, 1.08, 0.26, 0.01]';
Sigma2 = diag([8.41, 12.06, 0.12, 0.22, 1.49, 1.77, 0.35, 2.73]);
 
 
%Number of samples for Monte-Carlo, start with 1 million, run a few times
%to see how much computed Bayes error vary, if it varies quite bit, then
%increase the number of samples, do this until Bayes error become
%relatively stable. 
N = 1000000;  
 
e = BayesErrorMonteCarlo(n, P1, M1, Sigma1, P2, M2, Sigma2, N );
 
% Bayes Error in this case should 1.46%
sprintf('Bayes Error in this case should be %.3f', 0.018)
 
sprintf('Bayes Error computed is %.3f', e)