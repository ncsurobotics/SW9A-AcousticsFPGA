data = readmatrix('a(theta).csv');

[rows, cols] = size(data);

doCompare = true;

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