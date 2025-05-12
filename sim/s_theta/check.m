data = readmatrix('a(theta).csv');

[rows, cols] = size(data);

doCompare = true;

aj_buffer = zeros(19,1);
my_buffer = zeros(19,1);

R_LOWER_BOUND = -250;
R_UPPER_BOUND  = 250;

real_part = randi([R_LOWER_BOUND,R_UPPER_BOUND], 4, 4); 
imag_part = randi([R_LOWER_BOUND,R_UPPER_BOUND], 4, 4);
r_matrix = complex(real_part, imag_part);
for theta = 1:cols
    aj = data(:,theta);
    denom = data(:,theta)' * data(:,theta);
    num = data(:,theta) * data(:,theta)';
    theta;
    result = 4096 * num/denom;
    aj_result = aj' * r_matrix * aj / (aj' * aj);
    aj_buffer(theta) = aj_result;
    my_result = sum(result .* r_matrix,'all');
    my_buffer(theta) = my_result/4096;
    theta
    my_buffer(theta)
    result
    (result - (result)');

    for x = 1:16
        buffer(theta * 19 + x) = result(x);
        sorted_buffer(x,theta) = result(x);
        if result(x) > 2^31
            fprintf("Overflow. Theta: %d, Index: %d, Value: %d\n", theta, x, result(x));
        end
        if result(x) < -2^31
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