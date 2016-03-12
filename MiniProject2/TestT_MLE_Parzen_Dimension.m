%Classification Time by varying Dimensionality
Prior1=0.5;
Prior2=0.5;
%Dimension of Data Defined
plot([],[])
ET_MLE=zeros(30,1);
VART_MLE=zeros(30,1);
ET_P=zeros(30,1);
VART_P=zeros(30,1);
hold on
for dim=1:30
    Mean1=zeros(dim,1);
    Mean2=eye(dim,1);
    %The Means are chosen like this to make sure the euclidean distance is
    %same
    Cov1=eye(dim,dim);
    Cov2=Cov1+eye(dim,1)*eye(dim,1)';
    et_mle=zeros(100,1);
    et_p=zeros(100,1);
    h=10;%h=10 seems to be ideal
    [atrain,btrain]= genranddatafu(Prior1,Mean1,Cov1,Prior2,Mean2,Cov2,70);
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
    ET_MLE(dim)=mean(et_mle);
    VART_MLE(dim)=var(et_mle);
    ET_P(dim)=mean(et_p);
    VART_P(dim)=var(et_p);
end

errorbar(ET_MLE,VART_MLE);
errorbar(ET_P,VART_P);
legend('CPU Time (MLE)','CPU Time (Parzen)');
legend boxoff;
