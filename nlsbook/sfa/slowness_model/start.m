%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script sets up and runs a simulation of the model of
% self-organization of the primary visual cortex described in
% P.Berkes, L.Wiskott (2003) Slow feature analysis yields a rich repertoire
% of complex cell properties, Cognitive Sciences EPrint Archive (CogPrint)
% 2804.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% make sure that sfa-tk is in your Matlab path
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% sfa-tk must be in your Matlab path and the demo directory has to be
% your current working directory

 addpath ../sfa_tk/sfa
 addpath ../sfa_tk/lcov
% cd MY_DEMO_PATH

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% define the simulation's parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% number of dimensions to be kept after PCA
input_dim = 50;

% filenames of the input images (black and white images only)
imgs = {'data/image1.tif','data/image2.tif','data/image3.tif',...
	'data/image4.tif','data/image5.tif'};

% name of the file where the results are saved
savefname = 'simulation_results';


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% perform a simulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hdl = simulation(input_dim, imgs);

% save the simulation
fprintf('save the simulation results in %s\n', savefname);
sfa_save(hdl, savefname);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% display the optimal stimuli
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ! this is the norm of the optimal stimulus. It should be chosen to be
% ! representative of the typical input, e.g. by choosing it to be the mean
% ! input norm. We have chosen here an arbitrary but realistic norm.
nrm = 2;
% tolerance for the computation of the optimal stimulus
tol = 1e-8;

% show the optimal excitatory stimuli
figure(1); set(gcf,'Name','Optimal excitatory stimuli');
fprintf('show the optimal excitatory stimuli\n');
show_optimal(hdl, nrm, tol);

% show the optimal inhibitory stimuli
figure(2); set(gcf,'Name','Optimal inhibitory stimuli');
fprintf('show the optimal inhibitory stimuli\n');
show_optimal(hdl, nrm, tol, 'show_xm', 1);

% if you want to remove the SFA object from memory
%sfa_clear(hdl);
