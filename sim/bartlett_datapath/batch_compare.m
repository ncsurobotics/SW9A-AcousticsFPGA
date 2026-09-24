clear all;
close all;
baseDir = "auto_tests_v5";

% Get list of subdirectories
dirs = dir(baseDir);

% Filter out "." and ".." and keep only directories
subdirs = dirs([dirs.isdir]);
subdirs = subdirs(~ismember({subdirs.name}, {'.', '..'}));
num_tests = numel(subdirs);
percent_errors = zeros(num_tests, 1);

% Loop through each subdirectory
for k = 1:length(subdirs)
    subdirPath = fullfile(baseDir, subdirs(k).name);
    fprintf('Processing: %s\n', subdirPath);
    
    % Call your function with the subdirectory path
    %compare_oracles(subdirPath);
    %compare(subdirPath);
    %compare_fourier(subdirPath);
    %compare_rxx(subdirPath);
    %compare_max_freq_vec(subdirPath);
    percent_errors(k) = get_oracle_verilog_delta(subdirPath);
end

writematrix(percent_errors,"deltas.csv");

% === Test index for plotting ===
test_idx = 1:num_tests;

% ============================================================
% High-quality plot
% ============================================================

figure('Color','w','Position',[100 100 900 500]);

plot(test_idx, percent_errors, ...
     '-o', ...
     'LineWidth', 1.8, ...
     'MarkerSize', 6, ...
     'MarkerFaceColor', [0.2 0.4 0.8]);

grid on;
grid minor;

xlabel('Test Number', 'FontSize', 13, 'FontWeight', 'bold');
ylabel('Mean Percent Error (%)', 'FontSize', 13, 'FontWeight', 'bold');

title('Oracle vs Verilog Mean Percent Error Across Test Cases', ...
      'FontSize', 14, 'FontWeight', 'bold');

set(gca, ...
    'FontSize', 12, ...
    'LineWidth', 1.2, ...
    'TickDir', 'out');

xlim([1 num_tests]);

% Optional: tighten Y limits for clarity
ylim([0 max(percent_errors)*1.1]);

% === Optional save for paper ===
% exportgraphics(gcf, 'percent_error_vs_test.png', 'Resolution', 300);