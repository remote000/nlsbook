function x=random_signal(len, n, mn, mx),
% RANDOM_SIGNAL creates a random signal
%
%   X=RANDOM_SIGNAL(LEN, N, MN, MX) create a (periodic) random signal X. The
%   signal is created by choosing random (uniform distribution) phases and
%   amplitudes of the first N Fourier components.
%
%   LEN is the length of X
%   N is the number of Fourier component to keep (the speed of the signal
%     grows with the squared root of N)
%   MN,MX define the minumum and maximum possible value of X

  x=zeros(1,len);
  % phases
  phi = rand(n,1)*2*pi;
  % amplitudes
  a = rand(n,1);
  
  % compute the new signal
  for k=1:n,
    t=(1:len)/len*2*pi*(k-1);
    x=x+a(k)*sin(t+phi(k));
  end
  % mean zero
  x=x/n/2+0.5;
  
  % rescale such that it lies between mn and mx
  x=x.*(mx-mn)+mn;

