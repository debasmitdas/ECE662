function [ z ] = discErr(x,P1,M1,Sigma1,P2,M2,Sigma2, label)
%compute 3.119 and return number of samples that are misclassified
%Written by J. Zhou
%Modified by Debasmit Das
%0-implies first class ; 1-implies second class

 
[M,N] = size(x); %M samples
 
invSigma1 = inv(Sigma1);
invSigma2 = inv(Sigma2);
temp = 0.5*log(det(Sigma1)/det(Sigma2)) - log(P1/P2);
 
y = zeros(1,M);
 
for i = 1:M          
 
        if  0.5*(x(i,:)'-M1)'*invSigma1*(x(i,:)'-M1) - ...
                0.5*(x(i,:)'-M2)'*invSigma2*(x(i,:)'-M2) + temp > 0   
            if label(i) == 0
                y(i) = 0;
            else
                y(i) = 1;
            end
        else
            if label(i) == 1
                y(i) = 1;
            else
                y(i) = 0;
            end
        end
 
end
 
z = sum(y)/M;
 
end