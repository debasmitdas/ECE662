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
ET_MLE=zeros(30,1);
VART_MLE=zeros(30,1);
ET_P=zeros(30,1);
VART_P=zeros(30,1);
hold on
for d=1:30
    Mean2=d*eye(Dimension,1);
    %test=zeros(100,1);
    et_mle=zeros(100,1);
    et_p=zeros(100,1);
    h=10;%h=10 seems to be ideal
    [atrain,btrain]= genranddatafu(Prior1,Mean1,Cov1,Prior2,Mean2,Cov2,100);
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
        t=cputime;
        e_mle(j)=discErr(atest,Prior1,mu1',sigma1,Prior2,mu2',sigma2, btest);
        et_mle(j)=cputime-t;
        t=cputime;
        e_p(j)=errorParzen(h, atest, btest, Data1, Data2);
        et_p(j)=cputime-t;
    end
    %plot(d,z(i),'gx'); For Plotting the 100 emperical error points

    %plot(d, BayesErrorMonteCarlo(Dimension,Prior1,Mean1,Cov1,Prior2,Mean2,Cov2,1000),'k*')
    %Tte(d)=mean(testt);
    %TteVAR(d)=var(testt);
    ET_MLE(d)=mean(et_mle);
    VART_MLE(d)=var(et_mle);
    ET_P(d)=mean(et_p);
    VART_P(d)=var(et_p);
end

errorbar(ET_MLE,VART_MLE);
errorbar(ET_P,VART_P);
legend('CPU Time (MLE)','CPU Time (Parzen)');
