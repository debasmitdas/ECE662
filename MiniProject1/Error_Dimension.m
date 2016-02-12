%Effect of dimensionality on Error Rate
Prior1=0.5;
Prior2=0.5;
n=2;
d=1;
z=zeros(100,1);
plot([],[])
hold on
for dim=1:30
    Mean1=zeros(dim,1);
    Mean2=eye(dim,1);
    %The Means are chosen like this to make sure the euclidean distance is
    %same
    Cov1=eye(dim,dim);
    Cov2=Cov1+eye(dim,1)*eye(dim,1)';
for i=1:100
    [a,b]= genranddatafu(Prior1,Mean1,Cov1,Prior2,Mean2,Cov2,1000);
    z(i)=discErr(a,Prior1,Mean1,Cov1,Prior2,Mean2,Cov2, b);
    %plot(d,z(i),'gx'); % You can use this to plot the emperical error but
    %plot becomes cluttered
end
    plot(dim, BayesErrorMonteCarlo(dim,Prior1,Mean1,Cov1,Prior2,Mean2,Cov2,10000),'r*')
    plot(dim,mean(z),'ko');
    plot(dim,mean(z)+sqrt(var(z)),'k^')
    plot(dim,mean(z)-sqrt(var(z)),'kv')
end