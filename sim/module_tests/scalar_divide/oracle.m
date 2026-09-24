% Define matrix size
rows = 4;
cols = 4;

% Generate random complex numbers
real_part = randi([-10000,10000], rows, cols) %randi([-32768, 32767], rows, cols); % 16-bit signed integers
imag_part = randi([-10000,10000], rows, cols) %randi([-32768, 32767], rows, cols);
matrix = complex(real_part, imag_part);
% Loop through each row and save to a separate file
filename = sprintf('input.txt'); % Create file name (e.g., row_001.txt)
fid = fopen(filename, 'w'); % Open file for writing
for i = 1:rows
    for j = 1:cols
        real_hex = dec2hex(typecast(int32(real_part(i, j)), 'int32'), 8); % Convert real part to hex
        imag_hex = dec2hex(typecast(int32(imag_part(i, j)), 'int32'), 8); % Convert imag part to hex
        fprintf(fid, '%s%s\n', imag_hex, real_hex); % Write to file
    end
end
fclose(fid); % Close file

disp('Files generated successfully.');

result = matrix/256 %generate hermician

filename = sprintf('matlab_output.txt'); % Create file name (e.g., row_001.txt)
fid = fopen(filename, 'w'); % Open file for writing
for i = 1:rows
    for j = 1:cols
        real_hex = dec2hex(typecast(int16(real(result(i, j))), 'int16'), 4); % Convert real part to hex
        imag_hex = dec2hex(typecast(int16(imag(result(i, j))), 'int16'), 4); % Convert imag part to hex
        fprintf(fid, '%s%s\n', imag_hex, real_hex); % Write to file
    end
end
fclose(fid); % Close file
