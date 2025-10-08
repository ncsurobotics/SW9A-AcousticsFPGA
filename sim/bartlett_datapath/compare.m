function compare(path)
directory = 'test_4_32_180_4'
% === User settings ===
mat_file = directory+"\\magP.mat";    % .mat file to load
csv_file = directory+"\\all_result_dec.csv";    % .csv file to load
img_file = directory+"\\comparison.png";  % output image file

% === Load .mat file ===
mat_data = load(mat_file);

% If multiple variables exist, grab the first numeric one
vars = fieldnames(mat_data);
mat_var = [];
for k = 1numel(vars)
    if isnumeric(mat_data.(vars{k}))
        mat_var = mat_data.(vars{k});
        break
    end
end

if isempty(mat_var)
    error('No numeric variable found in %s', mat_file);
end

% === Load .csv file ===
csv_data = readmatrix(csv_file);

mat_var = mat_var .* 5e6
csv_data = csv_data .* 1e-6

% === Plot both ===
figure;
hold on;
plot(mat_var, 'LineWidth', 2);
plot(csv_data, '--', 'LineWidth', 2);
legend({'Oracle','Verilog'});
xlabel('Index');
ylabel('Value');
title('Oracle vs Verilog Comparison');
grid on;

% === Save figure ===
saveas(gcf, img_file);
disp(['Saved figure as ', img_file]);
end