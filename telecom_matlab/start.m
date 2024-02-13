
%% Get current path

p = mfilename('fullpath');
s = regexp(p, filesep, 'split');
path = s{1};
for i = 2:length(s)-1
    path = [path filesep s{i}];
end


%% Start GUI
run(fullfile(path,'gui','basic_lab_main.mlapp'))