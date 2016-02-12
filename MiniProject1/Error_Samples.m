%Effect of No. of Classification examples on Error Rate
Prior1=0.5;
Prior2=0.5;
dimension=2;

%2D Data
Mean1=zeros(dimension,1);
Mean2=eye(dimension,1);
%Covariance Matrices are same
Cov1=[1, 0.5 ; 0.5 ,1];
Cov2=eye(dimension,dimension);
z=zeros(100,1);
plot([],[])
hold on
for s=1:30
    
for i=1:100
    [a,b]= genranddatafu(Prior1,Mean1,Cov1,Prior2,Mean2,Cov2,s*5);
    z(i)=discErr(a,Prior1,Mean1,Cov1,Prior2,Mean2,Cov2, b);
    %plot(d,z(i),'gx');
end
    plot(s, BayesErrorMonteCarlo(dimension,Prior1,Mean1,Cov1,Prior2,Mean2,Cov2,1000),'r*')
    plot(s,mean(z),'ko');
    plot(s,mean(z)+sqrt(var(z)),'k^')
    plot(s,mean(z)-sqrt(var(z)),'kv')
end