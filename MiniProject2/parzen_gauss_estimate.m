%Function to estimate density using Parzen Windows
% Gaussian Kernel is used and h is the window parameter
% x is a row vector
function pn=parzen_gauss_estimate(h, Data, x)
  [n, d] = size (Data);
  hn=h/sqrt(n);
  phi = gauss_kernel((Data - ones(n,1)*x)/hn);
  pn = sum(phi)/(hn);
end