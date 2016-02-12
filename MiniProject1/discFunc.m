function [ z ] = discFunc(x,P1,M1,Sigma1,P2,M2,Sigma2, CFlag)
%compute  and return number of samples that are misclassified
%Written by J. Zhou
 
[N,M] = size(x); %M samples
 
invSigma1 = inv(Sigma1);
invSigma2 = inv(Sigma2);
temp = 0.5*log(det(Sigma1)/det(Sigma2)) - log(P1/P2);
 
y = zeros(1,M);
 
for i = 1:M          
 
        if  0.5*(x(:,i)-M1)'*invSigma1*(x(:,i)-M1) - ...
                0.5*(x(:,i)-M2)'*invSigma2*(x(:,i)-M2) + temp > 0   
            if CFlag == 1
                y(i) = 1;
            else
                y(i) = 0;
            end
        else
            if CFlag == 1
                y(i) = 0;
            else
                y(i) = 1;
            end
        end
 
end
 
z = sum(y);
 
end