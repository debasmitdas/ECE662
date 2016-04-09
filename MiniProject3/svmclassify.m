%This is the code for svm classification 
svmM = fitcsvm(samples,l,'KernelFunction','rbf','BoxConstraint',1,'ClassNames',[-1,1]);

figure;
h(1:2) = gscatter(samples(:,1),samples(:,2),l,'rb','.');
hold on
ezpolar(@(x)1);
h(3) = plot(samples(svmM.IsSupportVector,1),samples(svmM.IsSupportVector,2),'ko');
%contour(x1Grid,x2Grid,reshape(scores(:,2),size(x1Grid)),[0 0],'k');
legend(h,{'-1','+1','Support Vectors'});
axis equal
hold off

%Do the testing here