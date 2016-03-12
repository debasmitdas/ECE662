%Functions to Compute Error Using Parzen Method
function e=errorParzen(h,DataTest,LabelTest,DataTrain1,DataTrain2)
ella=0;
size_test=size(DataTest,1);

for i=1:size_test
    p1=parzen_gauss_estimate(h,DataTrain1,DataTest(i,:));
    p2=parzen_gauss_estimate(h,DataTrain2,DataTest(i,:));
    if p1>p2    
       if LabelTest(i) == 1
            ella=ella+1;
       else
            ella=ella;
       end
    else
       if LabelTest(i) == 0
            ella=ella+1;
       else
            ella=ella;
       end
    end
 
end
e=ella/size_test;
end
    