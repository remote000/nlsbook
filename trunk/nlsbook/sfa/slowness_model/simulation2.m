function hdl = simulation(input_dim, imgs, varargin),
% SIMULATION performs a simulation
%
% HDL = SIMULATION(INPUT_DIM, IMGS) Perform a simulation. The input
%   dimensionality is reduced to INPUT_DIM dimensions. IMGS is a cell array
%   of filenames of images, from which the image sequences are created. The
%   function returns the handle HDL to the SFA object of the resulting
%   slowly-varying functions.
%
%   Optional arguments can be specified by appending
%   'ArgumentName',ArgumentValue pairs to the argument list
%   (e.g. SIMULATION(INPUT_DIM,IMGS,'nsequences',1000,'nframes',50).
%
%   Possible optional arguments:
%   'output_dim' (default:200) number of slowly varying functions to
%                              compute
%
%   'h' (default:16) height of the input patch
%   'w' (default:16) width of the input patch
%
%   'nsequences' (default:2500) total number of sequences to create
%   'nframes' (default:100) number of frames in each sequence (warning:
%     a change to the number of frames also changes the statistics of the
%     transformations. If you want to compare simulations with different
%     transformation parameters, make sure that nframes stays constant).
%
%   'tr_range' (default:75)
%   'zm_range' (default:[0.3,2])
%   'tr','rt','zm' (default:4,8,8) parameters of translation, rotation,
%     and zoom. See IMGSEQUENCE for a description.
%
%   'verbose' (default:1) if 1, some text messages are displayed during
%     the simulation and the loaded images are plotted in a window.
%   'msginterval' (defalut:50), if VERBOSE==1, print a message every
%     MSGINTERVAL sequences
%
%   See also: IMGSEQUENCE
  
  %%%% default values
  load can_120row_still;
  data2=data;
  clear data;  
  % number of slowly varying functions to keep
  ctxt.output_dim = min(200, xp_dim(input_dim));
  
  % input patch height and width
  ctxt.h = 16; ctxt.w = 16;
  % number of sequences, number of frames for each sequence
  ctxt.nsequences = size(data2,2); ctxt.nframes=100;
    
  % translation range
  ctxt.tr_range = 75;
  % zoom range
  ctxt.zm_range = [0.3,2];
  % xsequences parameters for translation, rotation and zoom
  ctxt.tr = 4; ctxt.rt = 8; ctxt.zm = 8;
  
  % preprocessing method
  ctxt.preprocessing = 'PCA';

  % set verbose to zero to disable the messages
  ctxt.verbose = 1;
  % print a message every msginterval sequences
  ctxt.msginterval = 50;

  % overwrite with user-defined list of settings
  for k = 1:2:length(varargin),
    % error check: the optional arguments must be defined as name-value pairs
    if ~ischar(varargin{k}),
      error 'Setting names must be strings';
    end
    % set variable value
    ctxt=setfield(ctxt,varargin{k},varargin{k+1});
  end

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  % number of images
  nimgs = length(imgs);
  % number of sequences per image
  nnextimg = fix(ctxt.nsequences/nimgs)+1;
  
  % create an SFA2 object
  if ctxt.verbose, fprintf('create a new SFA object\n'); end
  hdl = sfa2_create(input_dim, ctxt.output_dim, ctxt.preprocessing);
  

  % loop over the two SFA steps
  for step_name = {'preprocessing', 'expansion'},
    % loop over all sequences
    for i=1:ctxt.nsequences,
      

      % print a message every msginterval sequences
      if ~mod(i,ctxt.msginterval) & ctxt.verbose,
	fprintf('sequence #%d\n',i);
      end

      % create a new image sequence
      DATA=zeros(ctxt.nframes,ctxt.h*ctxt.w);
      for nf=1:ctxt.nframes
          dfrm=rgb2gray(data2{i}(nf).cdata);
          DATA(nf,:)=double(dfrm(:))/255;
      end

      % update the SFA object
      sfa_step(hdl, DATA, step_name{1});
    end
  end
  
  % close the SFA algorithm
  if ctxt.verbose, fprintf('close the SFA algorithm\n'); end
  sfa_step(hdl,[],'sfa');
