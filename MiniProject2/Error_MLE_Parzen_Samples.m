%Error Calculation by varying Sample Size
Prior1=0.5;
Prior2=0.5;
%Dimension of Data Defined
Dimension=10;
Mean1=zeros(Dimension,1);
Mean2=eye(Dimension,1);
%Covariance Matrix are set here
Cov1=0.5*ones(Dimension,Dimension)+0.5*eye(Dimension,Dimension);
Cov2=eye(Dimension,Dimension);
%For training use 500 points of 1 class and 500 points of another class
plot([],[])
E_MLE=zeros(10,1);
VAR_MLE=zeros(10,1);
%Ttr=zeros(30,1);
%Tte=zeros(30,1);
%TteVAR=zeros(30,1);
E_P=zeros(10,1);
VAR_P=zeros(10,1);
hold on
for s=1:10
    e_mle=zeros(100,1);
    e_p=zeros(100,1);
    h=10;%h=10 seems to be ideal
    [atrain,btrain]= genranddatafu(Prior1,Mean1,Cov1,Prior2,Mean2,Cov2,s*30);
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
    %t=cputime;
    [mu1, sigma1]=mle_normal(Data1);
    [mu2, sigma2]=mle_normal(Data2);
    %Ttr(d)=cputime-t;
    %testt=zeros(100,1);
    for j=1:100
        [atest,btest]= genranddatafu(Prior1,Mean1,Cov1,Prior2,Mean2,Cov2,30);
        %t=cputime;
        e_mle(j)=discErr(atest,Prior1,mu1',sigma1,Prior2,mu2',sigma2, btest);
        %testt(j)=cputime-t;
        e_p(j)=errorParzen(h, atest, btest, Data1, Data2);
    end
    %plot(d,z(i),'gx'); For Plotting the 100 emperical error points

    %plot(d, BayesErrorMonteCarlo(Dimension,Prior1,Mean1,Cov1,Prior2,Mean2,Cov2,1000),'k*')
    %Tte(d)=mean(testt);
    %TteVAR(d)=var(testt);
    E_MLE(s)=mean(e_mle);
    VAR_MLE(s)=var(e_mle);
    E_P(s)=mean(e_p);
    VAR_P(s)=var(e_p);
end
%legend('Bayes');
%plot(Ttr);
%errorbar(Tte,TteVAR);
errorbar(E_MLE,VAR_MLE);
errorbar(E_P,VAR_P);
legend('Error Rate (MLE)','Error Rate (Parzen)');
