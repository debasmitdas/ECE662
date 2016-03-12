%Classification Time by varying sample size
Prior1=0.5;
Prior2=0.5;
%Dimension of Data Defined
Dimension=2;
Mean1=zeros(Dimension,1);
Mean2=eye(Dimension,1);
%Covariance Matrix are set here
Cov1=0.5*ones(Dimension,Dimension)+0.5*eye(Dimension,Dimension);
Cov2=eye(Dimension,Dimension);
%For training use 500 points of 1 class and 500 points of another class
plot([],[])
ET_MLE=zeros(10,1);
VART_MLE=zeros(10,1);
ET_P=zeros(10,1);
VART_P=zeros(10,1);
hold on
for s=1:10
    
    %test=zeros(100,1);
    et_mle=zeros(100,1);
    et_p=zeros(100,1);
    h=10;%h=10 seems to be ideal
    [atrain,btrain]= genranddatafu(Prior1,Mean1,Cov1,Prior2,Mean2,Cov2,s*100);
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
        [atest,btest]= genranddatafu(Prior1,Mean1,Cov1,Prior2,Mean2,Cov2,s*5);
        t=cputime;
        e_mle(j)=discErr(atest,Prior1,mu1',sigma1,Prior2,mu2',sigma2, btest);
        et_mle(j)=cputime-t;
        t=cputime;
        e_p(j)=errorParzen(h, atest, btest, Data1, Data2);
        et_p(j)=cputime-t;
    end
    ET_MLE(s)=mean(et_mle);
    VART_MLE(s)=var(et_mle);
    ET_P(s)=mean(et_p);
    VART_P(s)=var(et_p);
end

errorbar(ET_MLE,VART_MLE);
errorbar(ET_P,VART_P);
legend('CPU Time (MLE)','CPU Time (Parzen)');
legend boxoff;
