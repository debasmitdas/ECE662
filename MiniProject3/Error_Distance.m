%Code to compare classifier error with distance
%Priors are defined
Prior1=0.5;
Prior2=0.5;
%Dimension of Data defined
Dimension=40;
%Number of training and testing points
tr=400;te=100;
%Defining the parameters
Mean1=zeros(Dimension,1);

%Covariance Matrix are set here
Cov1=0.5*ones(Dimension,Dimension)+0.5*eye(Dimension,Dimension);
Cov2=eye(Dimension,Dimension);
%Cov2=Cov1;
%For training use 500 points of 1 class and 500 points of another class
E_SVM=zeros(te,1);
VAR_SVM=zeros(te,1);
E_MLE=zeros(te,1);
VAR_MLE=zeros(te,1);
E_LDA=zeros(te,1);
VAR_LDA=zeros(te,1);
E_P=zeros(te,1);
VAR_P=zeros(te,1);

hold on
for dis=1:10 % As distance between 2 distributions are varied
    Mean2=dis*eye(Dimension,1);
    %test=zeros(100,1);
    %e_svm=zeros(100,1);
    %e_p=zeros(100,1);
    %h=10;%h=10 seems to be ideal
    hP=10; %Parzen scale parameter
    [atrain,btrain]= genranddatafu(Prior1,Mean1,Cov1,Prior2,Mean2,Cov2,tr);
    
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

    
  
    %This is the code for svm classification 

    svmM = fitcsvm(atrain,btrain,'KernelFunction','rbf','BoxConstraint',10,'ClassNames',[0,1],'KernelScale','auto');
    
    %Code Plot for visualizing Data
    if(Dimension==2)
    figure;
    hold on
    h(1:2) = gscatter(atrain(:,1),atrain(:,2),btrain,'rb','.');
    
    %ezpolar(@(x)1);
    h(3) = plot(atrain(svmM.IsSupportVector,1),atrain(svmM.IsSupportVector,2),'ko');
    d = 0.02;
    [x1Grid,x2Grid] = meshgrid(min(atrain(:,1)):d:max(atrain(:,1)),...
    min(atrain(:,2)):d:max(atrain(:,2)));
    xGrid = [x1Grid(:),x2Grid(:)];
    [~,scores] = predict(svmM,xGrid);
    contour(x1Grid,x2Grid,reshape(scores(:,2),size(x1Grid)),[0 0],'k');
    legend(h,{'-1','+1','Support Vectors'});
    title(['SVM Classification with RBF Kernel,  ', 'Scale Parameter =  ',num2str(svmM.KernelParameters.Scale),',  Distance = ',num2str(dis)])
    xlabel('x') % x-axis label
    ylabel('y') % y-axis labe
    axis equal
    hold off
    end
    
    %Here the MLE Computation is done
    [mu1, sigma1]=mle_normal(Data1);
    [mu2, sigma2]=mle_normal(Data2);

    %Training the LDA based Linear Classifier
    [Z,W,Th,Mu1,Mu2] = lintrain(atrain,btrain,1);
    
    
    
    for j=1:100
        [atest,btest]= genranddatafu(Prior1,Mean1,Cov1,Prior2,Mean2,Cov2,te);
        e_mle(j)=discErr(atest,Prior1,mu1',sigma1,Prior2,mu2',sigma2, btest);
        %testt(j)=cputime-t;
        [label,scores] = predict(svmM,atest);
        e_svm(j)=mean(abs(label-btest));
        e_p(j)=errorParzen(hP, atest, btest, Data1, Data2);
        e_lda(j)=errorLDA(atest,btest,W,Th,Mu1,Mu2);
    end
    E_SVM(dis)=mean(e_svm);
    VAR_SVM(dis)=var(e_svm);
    E_P(dis)=mean(e_p);
    VAR_P(dis)=var(e_p);
    E_MLE(dis)=mean(e_mle);
    VAR_MLE(dis)=var(e_mle);
    E_LDA(dis)=mean(e_lda);
    VAR_LDA(dis)=var(e_lda);
end
%legend('Bayes');
%plot(Ttr);
%errorbar(Tte,TteVAR);
errorbar(E_SVM,VAR_SVM);
hold on
errorbar(E_P,VAR_P);
errorbar(E_MLE,VAR_MLE);
errorbar(E_LDA,VAR_LDA);
title('Effect of Distance between distributions on Error Rate');
legend('Error Rate (SVM)','Error Rate (Parzen)','Error Rate (MLE)','Error Rate (LDA)');
legend boxoff;
xlabel('Distance (d)') % x-axis label
ylabel('Error Rate') % y-axis label
    

%Do the testing here
