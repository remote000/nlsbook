function [DATA,x_signal,y_signal,rt_signal,zm_signal]=imgsequence(im, h, w, nframes, trrg, trfact, rtfact, zmrg,zmfact)
% IMGSEQUENCE returns a random image sequence.
%
%   [DATA] = IMG_SEQUENCE(IM, H,W, NFRAMES, ...
%                         TRRG,TRFACT, RTFACT, ZMRG,ZMFACT)
%
%   Create an image sequence of NFRAMES frames of size H x W pixels out
%   of the image IM. The sequence is created by choosing an initial
%   position at random, cutting a square window and moving it around by
%   translation, rotation, and zoom.
%
%   Translation, rotation and zoom are created by the function
%   RANDOM_SIGNAL, which returns a random signal that varies smoothly in
%   time. The amount of variation in time is controlled by the integer
%   numbers TRFACT, RTFACT, and ZMFACT (the higher they are, the faster it
%   varies). If one of this arguments is set to zero, the corresponding
%   transformation is not performed. TRRG is the maximal distance from the
%   initial random point reached by translation. ZMRG is a list of length 2
%   that gives the minimum and the maximum possible magnification reached by
%   zoom.
%
%   [DATA,X_SIGNAL,Y_SIGNAL,RT_SIGNAL,ZM_SIGNAL]=IMGSEQUENCE(...) returns
%   the position signals for the x and y coordinates, the rotation signal
%   and the zoom signal. This is sometimes useful to collect statistics
%   on the transformations.
%
%   See also RANDOM_SIGNAL.
    
    
% ver 3.0
  
  % size of the image
  sz=[size(im,1) size(im,2)];
  
  % repeat until the whole sequence lies inside the image
  repeat=1;
  while repeat,
    repeat=0;

    %% create translation signal (center of the patch)
    % random initial position (keep a margin of 3*w along the borders)
    x0=floor(rand(1,2).*(sz-6*w))+3*w;
    % random translation signal (if trfact==0, no translation)
    if trfact==0,
      x_signal=zeros(nframes,1)+x0(2);
      y_signal=zeros(nframes,1)+x0(1);
    else,
      x_signal=random_signal(nframes, trfact, -trrg, trrg)+x0(2);
      y_signal=random_signal(nframes, trfact, -trrg, trrg)+x0(1);
    end
    
    % create rotation signal (if rrfact==0, no rotation)
    if rtfact==0,
      rt_signal=zeros(nframes,1);
    else,
      rt_signal=random_signal(nframes, rtfact, 0, 2*pi);
    end
  
    % create zoom signal (if zmfact==0, no zoom)
    if zmfact==0,
      zm_signal=ones(nframes,1);
    else,
      zm_signal=random_signal(nframes, zmfact, zmrg(1), zmrg(2));
    end
    
    % allocate space for the sequence
    DATA=zeros(nframes,h*w);
      
    % loop over all frames
    for t=1:nframes,
      %%%% translation
      % current position
      x=[x_signal(t);y_signal(t)];
    
      %%%% zoom
      % compute the corners of the window after zoom
      xi(1)=x(1)-zm_signal(t)*w/2;
      xx(1)=x(1)+zm_signal(t)*w/2;
      xi(2)=x(2)-zm_signal(t)*h/2;
      xx(2)=x(2)+zm_signal(t)*h/2;
      % size of the window
      dx(1)=(xx(1)-xi(1))/(w-1);
      dx(2)=(xx(2)-xi(2))/(h-1);
      
      % position of all points in the window
      [XI,YI]=meshgrid(xi(1):dx(1):xx(1), xi(2):dx(2):xx(2));
      
      %%%% rotation
      % rotate the window's points
      alfa=rt_signal(t);
      XI=XI-x(1); YI=YI-x(2);
      XR=XI.*cos(alfa)+YI.*sin(alfa);
      YR=-XI.*sin(alfa)+YI.*cos(alfa);
      XI=XR+x(1); YI=YR+x(2);

      % compute the content of the frame by linear interpolation
      % this is a workaround for a bug in Matlab 7.0.0.19901 (R14)
      [M,N] = size(im);
      PATCH=interp2(1:N,1:M, im, XI, YI, '*linear');
      % it is also possible to perform cubic interpolation,
      % but it's much slower:
      %PATCH=interp2(im, XI, YI, '*cubic');

      % if the frame went out of the image, discard the sequence and
      % start from scratch
      if max(isnan(PATCH(:))),
	repeat=1; break;
      end
    
      % save the current frame
      DATA(t,:)=PATCH(:)';
    end
  end
