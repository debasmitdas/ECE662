%code for separating the samples into samples of class 1 and class 2
%Run this in the command line

samples1=[];samples2=[];
for i=1:size(l,1)
        if(l(i,1)==0)
            samples1=[samples1;samples(i,:)];
        else
            samples2=[samples2;samples(i,:)];
        end
end

plot(samples(:,1),samples(:,2),'r.','MarkerSize',15)