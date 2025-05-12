data = readmatrix('a(theta).csv')

[rows, cols] = size(data);

doFile = false;

for theta = 1:cols
    denom = data(:,theta)' * data(:,theta);
    num = data(:,theta) * data(:,theta)';
    theta
    result = 4096 * num/denom
    (result - (result)');
    if doFile
        filename = sprintf('s_%1d.txt', theta-1); % Create file name (e.g., row_001.txt)
        filename2 = sprintf("s_%1d.mat",theta-1);
        fid = fopen(filename, 'w'); % Open file for writing
        for i = 1:16
            real_hex = dec2hex(typecast(int32(real(result(i))), 'int32'), 8); % Convert real part to hex
            imag_hex = dec2hex(typecast(int32(imag(result(i))), 'int32'), 8); % Convert imag part to hex
            fprintf(fid, '%s%s\n', imag_hex, real_hex); % Write to file
            save(filename2,'result');
        end
        fclose(fid);
    end
    
end

