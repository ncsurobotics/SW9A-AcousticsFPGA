% ============================================================
% Aggregate oracle-vs-Verilog results across test cases
% ============================================================

clear;
clc;

clear all;
close all;
baseDir = "auto_tests_v5";

% Get list of subdirectories
dirs = dir(baseDir);

% Keep only real subdirectories (exclude . and ..)
subdirs = dirs([dirs.isdir] & ...
               ~ismember({dirs.name}, {'.', '..'}));

% Convert to full paths
test_dirs = strings(numel(subdirs), 1);
for k = 1:numel(subdirs)
    test_dirs(k) = fullfile(baseDir, subdirs(k).name);
end

num_tests = numel(test_dirs);

mean_percent_error = zeros(num_tests, 1);
max_index_match    = zeros(num_tests, 1);  % 1 = match, 0 = mismatch

% ============================================================
% Run tests
% ============================================================

for k = 1:num_tests
    dirk = test_dirs{k};

    % --- Mean percent error ---
    mean_percent_error(k) = get_oracle_verilog_delta(dirk);

    % --- Load oracle and verilog data for max-index check ---
    mat_data = load(dirk + "\new_algo_magP.mat");
    vars = fieldnames(mat_data);

    mat_var = [];
    for v = 1:numel(vars)
        if isnumeric(mat_data.(vars{v}))
            mat_var = mat_data.(vars{v});
            break
        end
    end

    csv_var = readmatrix(dirk + "\all_result_dec.csv");

    % Ensure vectors & equal length
    mat_var = mat_var(:);
    csv_var = csv_var(:);
    N = min(numel(mat_var), numel(csv_var));

    mat_var = mat_var(1:N);
    csv_var = csv_var(1:N);

    % --- Find index of maximum value ---
    [~, idx_mat] = max(mat_var);
    [~, idx_csv] = max(csv_var);

    % --- Compare ---
    max_index_match(k) = 10 *  min([abs((idx_mat - idx_csv)),abs((idx_mat - idx_csv)-18)]);
    if max_index_match(k) == 170
        max_index_match(k) = 10
    end
    if idx_mat > idx_csv
        max_index_match(k) = -max_index_match(k)
    end
end

test_idx = 1:num_tests;

% ============================================================
% Plot results
% ============================================================
figure('Color','w','Position',[100 100 950 650]);

% ============================================================
% Top plot: Mean Percent Error
% ============================================================
subplot(2,1,1)
plot(test_idx, mean_percent_error, ...
     '-o', ...
     'LineWidth', 1.8, ...
     'MarkerSize', 6, ...
     'MarkerFaceColor', [0.1 0.4 0.8]);

grid on;
grid minor;

ylabel('Mean Percent Error (%)', ...
       'FontSize', 13, 'FontWeight', 'bold');

title('Matlab vs Simulated Design Results', ...
      'FontSize', 14, 'FontWeight', 'bold');

set(gca, ...
    'FontSize', 12, ...
    'LineWidth', 1.2, ...
    'TickDir', 'out');

xlim([1 numel(test_idx)]);

% ============================================================
% Bottom plot: Max Index Match
% ============================================================
subplot(2,1,2)
h = stem(test_idx, max_index_match);
h.LineWidth  = 1.6;
h.MarkerSize = 7;
h.MarkerFaceColor = h.Color;

grid on;
grid minor;

xlabel('Test Number', ...
       'FontSize', 13, 'FontWeight', 'bold');

ylabel('DOA Difference', ...
       'FontSize', 13, 'FontWeight', 'bold');

set(gca, ...
    'FontSize', 12, ...
    'LineWidth', 1.2, ...
    'TickDir', 'out');

xlim([1 numel(test_idx)]);
