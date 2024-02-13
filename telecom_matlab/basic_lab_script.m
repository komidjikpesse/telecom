clear 
%% Load parameter file
p = mfilename('fullpath');
s = regexp(p, filesep, 'split');
path = s{1};
for i = 2:length(s)-1
    path = [path filesep s{i}];
end
load(fullfile(path,'files','exported_param.mat'));

%% Initialize Parameter
param = initialize_param(param);


%% Run simulation
results = run_simulation(param);

S = license('inuse');
if length(S) > 1
    warning('Usage of toolboxes detected')
end