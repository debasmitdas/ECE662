%Function for evaluationg gaussian. Here u should be a column vector
  function y = gaussian(u)
  d = size(u,1);
  y = exp(-(u'*u)/2)/((2*pi)^(d/2));
  end