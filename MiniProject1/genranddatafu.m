function [ z , l] = genranddatafu(p1,mu1,sigma1,p2,mu2,sigma2)
N = size(mu1,1);
sampleCount = 1000;
%mu1 = 4 * ones(N, 1); sigma1 = diag(3 * ones(N, 1));    % Class 1 Parameters.
%mu2 = 1 * ones(N, 1); sigma2 = diag(2 * ones(N, 1));    % Class 2 Parameters.
 
        % Dataset and labels.
gaussianSamples = zeros([sampleCount, N]);
sampleLabels = zeros([sampleCount, 1]);
 
        % Control via Uniform PDF.
uniform = rand([sampleCount, 1]);
 
              % Class 1 Probability. (Threshold) 
        % Proper implementation: Logical Indexing.
class1Mask = uniform <= p1;
class1Count = sum(class1Mask);
 
gaussianSamples(class1Mask, :) = mvnrnd(mu1, sigma1, class1Count);
sampleLabels(class1Mask) = 0;
 
class2Mask = uniform > p1;
class2Count = sum(class2Mask);
 
gaussianSamples(class2Mask, :) = mvnrnd(mu2, sigma2, class2Count);
sampleLabels(class2Mask) = 1;
 
disp(['Class 1 = ', int2str(class1Count), ', Class 2 = ', int2str(class2Count)]);
z=gaussianSamples
l=sampleLabels