%Function to evaluate gaussian kernel
% u here is a matrix where n is the number of examples
% Each example is a row
% d is the no. of columns or the no. of dimensions
function y=gauss_kernel(u)
  [n,d] = size(u);
  y=zeros(n,1);
  for i=1:n
    y(i) = gaussian(u(i,:)');
  end
end