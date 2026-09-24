function mean_percent_error = get_oracle_verilog_delta(path)
    directory = path;

    % === User settings ===
    mat_file = directory + "\new_algo_magP.mat";
    csv_file = directory + "\all_result_dec.csv";

    % Percent error rejection threshold
    MAX_PERCENT_ERROR = 75;   % percent (skip anything above this)
    EPS = 1e-12;                % avoid divide-by-zero

    % === Load .mat file ===
    mat_data = load(mat_file);

    vars = fieldnames(mat_data);
    mat_var = [];

    for k = 1:numel(vars)
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

    % Ensure column vectors
    mat_var  = mat_var(:);
    csv_data = csv_data(:);

    % Match lengths
    N = min(numel(mat_var), numel(csv_data));
    mat_var  = mat_var(1:N);
    csv_data = csv_data(1:N);

    % === Normalize both datasets (independent min–max to [-1, 1]) ===
    mat_norm = 2 * (mat_var - min(mat_var)) / (max(mat_var) - min(mat_var)) - 1;
    csv_norm = 2 * (csv_data - min(csv_data)) / (max(csv_data) - min(csv_data)) - 1;

    % === Percent error calculation ===
    percent_error_sum = 0;
    valid_count = 0;

    for i = 1:N
        oracle = mat_norm(i);

        % Skip near-zero oracle values (percent error meaningless)
        if abs(oracle) < EPS
            continue
        end

        pe = abs(csv_norm(i) - oracle) / abs(oracle) * 100;

        % Skip extreme outliers
        if pe > MAX_PERCENT_ERROR || isinf(pe) || isnan(pe)
            continue
        end

        percent_error_sum = percent_error_sum + pe;
        valid_count = valid_count + 1;
    end

    if valid_count == 0
        error('No valid samples after percent-error filtering.');
    end

    mean_percent_error = percent_error_sum / valid_count;
end
