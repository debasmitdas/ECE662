%Effect of distance between mean of Gaussians on Error Rate
Prior1=0.5;
Prior2=0.5;
%Dimension of Data Defined
Dimension=2;
Mean1=zeros(Dimension,1);

%Covariance Matrix are set here
Cov1=[1 0.5 ;0.5 1];
Cov2=eye(Dimesnion,Dimension);

plot([],[])
hold on
for d=1:30
    Mean2=d*eye(Dimension,1);
    e=zeros(100,1);
for j=1:100
    [a,b]= genranddatafu(Prior1,Mean1,Cov1,Prior2,Mean2,Cov2,1000);
    e(j)=discErr(a,Prior1,Mean1,Cov1,Prior2,Mean2,Cov2, b);
    %plot(d,z(i),'gx'); For Plotting the 100 emperical error points
end
    plot(d, BayesErrorMonteCarlo(Dimension,Prior1,Mean1,Cov1,Prior2,Mean2,Cov2,1000),'r*')
    plot(d,mean(e),'ko');
    plot(d,mean(e)+sqrt(var(e)),'k^')
    plot(d,mean(e)-sqrt(var(e)),'kv')
end
    
        
        
        