data = readmatrix('a(theta).csv');

[rows, cols] = size(data);

doFile = false;
doPrintHex = false;
doPlot = false;
doCompare = true;

buffer = zeros(19*16,1);
sorted_buffer = zeros(16,19);

aj_buffer = zeros(19,1);
my_buffer = zeros(19,1);

r_matrix = rand(4,4) + j * rand(4,4)
for theta = 1:cols
    aj = data(:,theta);
    denom = data(:,theta)' * data(:,theta);
    num = data(:,theta) * data(:,theta)';
    result;
    theta;
    result = 4096 * num/denom;
    aj_result = aj' * r_matrix * aj / (aj' * aj);
    aj_buffer(theta) = aj_result
    my_result = sum(result .* r_matrix,'all');
    my_buffer(theta) = my_result/4096
    (result - (result)');

    for x = 1:16
        buffer(theta * 19 + x) = result(x);
        sorted_buffer(x,theta) = result(x);
        if result(x) > 2^15
            fprintf("Overflow. Theta: %d, Index: %d, Value: %d\n", theta, x, result(x));
        end
        if result(x) < -2^15
            fprintf("Underflow. Theta: %d, Index: %d, Value: %d\n", theta, x, result(x));
        end
    end


    if doFile
        filename = sprintf('s_%1d.txt', theta-1); % Create file name (e.g., row_001.txt)
        filename2 = sprintf("s_%1d.mat",theta-1);
        fid = fopen(filename, 'w'); % Open file for writing
        for i = 1:16
            real_hex = dec2hex(typecast(int16(real(result(i))), 'int16'), 4); % Convert real part to hex
            imag_hex = dec2hex(typecast(int16(imag(result(i))), 'int16'), 4); % Convert imag part to hex
            fprintf(fid, '%s%s\n', imag_hex, real_hex); % Write to file
            save(filename2,'result');
        end
        fclose(fid);
    end

    if doPrintHex
        for i = 1:16
            real_hex = dec2hex(typecast(int16(real(result(i))), 'int16'), 4); % Convert real part to hex
            imag_hex = dec2hex(typecast(int16(imag(result(i))), 'int16'), 4); % Convert imag part to hex
            fprintf(1, '%s%s\n', imag_hex, real_hex); % Write to file
        end
    end
    
end

%plot(buffer,'.')
if doPlot
    figure; hold on;
    colors = lines(19);
    h = gobjects(1,19);  % Store scatter plot handles
    
    for col = 1:19
        x = real(sorted_buffer(:, col));
        y = imag(sorted_buffer(:, col));
        h(col) = scatter(x, y, 40, colors(col,:), 'filled');
    end
    
    xlabel('Real Part');
    ylabel('Imaginary Part');
    title('Complex Scatter Plot (S^H * S/S * S^H)');
    grid on;
    legend(h, arrayfun(@(c) sprintf('%d°', (c-1) * 10), 1:19, 'UniformOutput', false), 'Location', 'eastoutside');
    
    clear xlim
    clear ylim
    xlim([-1500 1500]);
    ylim([-1500 1500]);
    
    % Create checkboxes for each column
    for col = 1:19
        uicontrol('Style', 'checkbox', ...
                  'String', sprintf('%d°', (col-1) * 10), ...
                  'Value', 1, ... % checked by default (visible)
                  'Position', [20, 400 - col*20, 80, 20], ...
                  'Callback', @(src, ~) set(h(col), 'Visible', ternary(src.Value, 'on', 'off')));
    end
    

end





% Helper inline ternary function (define it at the end of your script)
function out = ternary(cond, valTrue, valFalse)
    if cond
        out = valTrue;
    else
        out = valFalse;
    end
end

if doCompare
% Create x-axis (1 to 19)
x = 1:19;

% Plot both on the same graph
figure;
plot(x, real(aj_buffer), '-o', 'LineWidth', 2);   % Plot A with circles
hold on;
plot(x, real(my_buffer), '-s', 'LineWidth', 2);   % Plot B with squares
hold off;

% Add labels, legend, and title
xlabel('Index');
ylabel('Value');
legend('aj_buffer', 'my_buffer');
title('Comparison of aj_buffer and my_buffer');
grid on;

end