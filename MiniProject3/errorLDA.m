%Function to compute error due to LDA
%Class 1 corresponds to 0 and Class 2 corresponds to 1
function e=errorLDA(DataTest,LabelTest,W,Th,Mu1,Mu2)
[n,d]=size(DataTest);
LabelPredicted=zeros(n,1);

for i=1:n
    
    ZTest=W'*DataTest(i,:)';
    ZMu1=W'*Mu1;
    ZMu2=W'*Mu2;
    
    if((ZTest-Th)*(ZMu1-Th)>0)
    LabelPredicted(i)=0;
    else
    LabelPredicted(i)=1;    
    end
end
e=mean(abs(LabelPredicted-LabelTest));
    