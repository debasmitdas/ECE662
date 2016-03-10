Prior1=0.5;
Prior2=0.5;
%Dimension of Data Defined
Dimension=2;
Mean1=zeros(Dimension,1);

%Covariance Matrix are set here
Cov1=[1 0.5 ;0.5 1];
Cov2=eye(Dimension,Dimension);
%For training use 500 points of 1 class and 500 points of another class
plot([],[])
E=zeros(30,1);
VAR=zeros(30,1);
Ttr=zeros(30,1);
Tte=zeros(30,1);
TteVAR=zeros(30,1);
hold on
for d=1:30
    Mean2=d*eye(Dimension,1);
    test=zeros(100,1);
    e=zeros(100,1);
    
    [atrain,btrain]= genranddatafu(Prior1,Mean1,Cov1,Prior2,Mean2,Cov2,1000);
    %Segregating Data
    
    Data1=[];
    Data2=[];
    for i=1:size(btrain,1)
        if(btrain(i,1)==0)
            Data1=[Data1;atrain(i,:)];
        else
            Data2=[Data2;atrain(i,:)];
        end
    end
    t=cputime;
    [mu1, sigma1]=mle_normal(Data1);
    [mu2, sigma2]=mle_normal(Data2);
    Ttr(d)=cputime-t;
    testt=zeros(100,1);
    for j=1:100
        [atest,btest]= genranddatafu(Prior1,Mean1,Cov1,Prior2,Mean2,Cov2,300);
        t=cputime;
        e(j)=discErr(atest,Prior1,mu1',sigma1,Prior2,mu2',sigma2, btest);
        testt(j)=cputime-t;
    end
    %plot(d,z(i),'gx'); For Plotting the 100 emperical error points

    %plot(d, BayesErrorMonteCarlo(Dimension,Prior1,Mean1,Cov1,Prior2,Mean2,Cov2,1000),'r*')
    Tte(d)=mean(testt);
    TteVAR(d)=var(testt);
    E(d)=mean(e);
    VAR(d)=var(e);
end
plot(Ttr);
errorbar(Tte,TteVAR);
%errorbar(E,VAR);