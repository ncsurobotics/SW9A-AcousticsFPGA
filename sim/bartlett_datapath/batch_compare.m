clear all;
close all;
baseDir = "auto_tests";

% Get list of subdirectories
dirs = dir(baseDir);

% Filter out "." and ".." and keep only directories
subdirs = dirs([dirs.isdir]);
subdirs = subdirs(~ismember({subdirs.name}, {'.', '..'}));

% Loop through each subdirectory
for k = 1:length(subdirs)
    subdirPath = fullfile(baseDir, subdirs(k).name);
    fprintf('Processing: %s\n', subdirPath);
    
    % Call your function with the subdirectory path
    %compare_oracles(subdirPath);
    compare(subdirPath);
    %compare_fourier(subdirPath);
    %compare_rxx(subdirPath);
    %compare_max_freq_vec(subdirPath);
end