Prior1=0.5;
Prior2=0.5;
d=0;
%2D Data
Mean1=[0;0]
Mean2=[0;d];
%Covariance Matrices are same
Cov1=[1 0;0 1];
Cov2=[1 0;0 1];
plot(d, BayesErrorMonteCarlo(2,Prior1,Mean1,Cov1,Prior2,Mean2,Cov2,1000));
hold on
for i=1:100
    plot(i*0.1, BayesErrorMonteCarlo(2,Prior1,Mean1,Cov1,Prior2,Mean2+[0;i*0.1],Cov2,1000),'rx');
end
hold off
   
     

