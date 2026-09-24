clear all;
close all;
baseDir = "auto_tests_sweep";

% Get list of subdirectories
dirs = dir(baseDir);

% Filter out "." and ".." and keep only directories
subdirs = dirs([dirs.isdir]);
subdirs = subdirs(~ismember({subdirs.name}, {'.', '..'}));

% Loop through each subdirectory
for k = 1:length(subdirs)
    subdirPath = fullfile(baseDir, subdirs(k).name);
    fprintf('Processing: %s\n', subdirPath);
    oracle_modified(subdirPath);
    close all;
end