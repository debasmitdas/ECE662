% This script contains the code fragments that are used to demonstrate the
% generation of different PDFs with different priors. Primary use of would
% be in decision making processes among two classes or more.
 
% ECE662:   Pattern Recognition & Decision Making Processes
% Title:    Generating two or more classes with controlled prior.
% Date:     2014-04-14
% Author:   Alex Gheith
 
sectionToRun = 4;
 
switch sectionToRun
 
    case 1
        % Generate Urn Example.
        % ---------------------
        greens = repmat('G', 1, 100);       % Probability = 0.5
        reds = repmat('R', 1, 100);         % Probability = 0.5
 
        mixed = [greens; reds];
        mixed = mixed(:);
 
        G = 0; R = 0;
        trialCount = 20;
 
        % Pick a ball at random, with replacement.
        for i = 1 : trialCount
            randomIndex = randi(length(mixed), 1);
            ball = mixed(randomIndex);
 
            if ball == 'G'
                G = G + 1;
            else
                R = R + 1;
            end
        end
 
        disp(['Greens = ', int2str(G), ', Reds = ', int2str(R)]);
 
    case 2
        % Create Gaussian data.
        % --------------------
        sampleCount = 1000;
 
        mu = 0; sigma = 1;
        y = random('Normal', mu, sigma, [sampleCount, 1]);
        % y = sigma .* randn([sampleCount, 1]) + mu;
 
        figure; histfit(y, 100, 'normal');
 
    case 3
        % Generate 1-D Data: Two Gaussian Classes.
        % ----------------------
        sampleCount = 10000;
        mu1 = -1; sigma1 = 0.5;     % Class 1 Parameters.
        mu2 = 1; sigma2 = 1;        % Class 2 Parameters.        
 
        % Dataset and labels.
        gaussianSamples = zeros([sampleCount, 1]);
        sampleLabels = zeros([sampleCount, 1]);
 
        % Control via Uniform PDF.
        uniform = rand([sampleCount, 1]);
 
        p1 = 0.25;              % Class 1 Probability. (Threshold)
 
%         % Conceptually
%         for i = 1 : length(uniform)
%             if uniform(i) < p1  % Get data for class 1.
%                 gaussianSamples(i) = random('Normal', mu1, sigma1, 1);
%                 sampleLabels(i) = 1;
%             else
%                 gaussianSamples(i) = random('Normal', mu2, sigma2, 1);
%                 sampleLabels(i) = 2;
%             end
%         end
 
        % Proper implementation: Logical Indexing.
        class1Mask = uniform <= p1;
        class1Count = sum(class1Mask);
 
        gaussianSamples(class1Mask, :) = random('Normal', mu1, sigma1, [class1Count, 1]);
        sampleLabels(class1Mask) = 1;
 
        class2Mask = uniform > p1;
        class2Count = sum(class2Mask);
 
        gaussianSamples(class2Mask, :) = random('Normal', mu2, sigma2, [class2Count, 1]);
        sampleLabels(class2Mask) = 2;
 
        disp(['Class 1 = ', int2str(class1Count), ', Class 2 = ', int2str(class2Count)]);
 
    case 4
        % Generate N-D Data: Two Gaussian Classes.
        % ----------------------
        N = 5;
        sampleCount = 10000;
        mu1 = 4 * ones(N, 1); sigma1 = diag(3 * ones(N, 1));    % Class 1 Parameters.
        mu2 = 1 * ones(N, 1); sigma2 = diag(2 * ones(N, 1));    % Class 2 Parameters.
 
        % Dataset and labels.
        gaussianSamples = zeros([sampleCount, N]);
        sampleLabels = zeros([sampleCount, 1]);
 
        % Control via Uniform PDF.
        uniform = rand([sampleCount, 1]);
 
        p1 = 0.5;              % Class 1 Probability. (Threshold)
 
        % Proper implementation: Logical Indexing.
        class1Mask = uniform <= p1;
        class1Count = sum(class1Mask);
 
        gaussianSamples(class1Mask, :) = mvnrnd(mu1, sigma1, class1Count);
        sampleLabels(class1Mask) = 1;
 
        class2Mask = uniform > p1;
        class2Count = sum(class2Mask);
 
        gaussianSamples(class2Mask, :) = mvnrnd(mu2, sigma2, class2Count);
        sampleLabels(class2Mask) = 2;
 
        disp(['Class 1 = ', int2str(class1Count), ', Class 2 = ', int2str(class2Count)]);
end
