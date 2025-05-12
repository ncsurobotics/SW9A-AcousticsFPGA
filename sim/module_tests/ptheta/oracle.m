% Define matrix size
rows = 4;
cols = 256;

% Generate random complex numbers
real_part = randi([-1000,1000], rows, cols) %randi([-32768, 32767], rows, cols); % 16-bit signed integers
imag_part = randi([-1000,1000], rows, cols) %randi([-32768, 32767], rows, cols);
matrix = complex(real_part, imag_part);

rxx = (matrix * matrix')/256 %generate hermician

fid = fopen("rxx.txt", 'w'); % Open file for writing

for k = 1:numel(rxx)
    val = rxx(k);  % Equivalent to m(i,j) in column-major order
    
    
    real_hex = dec2hex(typecast(int32(real_part(k)), 'int32'), 8); % Convert real part to hex
    imag_hex = dec2hex(typecast(int32(imag_part(k)), 'int32'), 8); % Convert imag part to hex
    fprintf(fid, '%s%s\n', imag_hex, real_hex); % Write to file
   
end

fclose(fid); % Close file

fid = fopen("weights.txt","w");
weights = zeros(1,19);
for i = 1:19
	
	mat_file = sprintf("C:\\Users\\Aweso\\Verilog\\Aquapack\\bartlett\\sim\\s_theta\\s_%1d.mat",i-1);
	hex_file = sprintf("C:\\Users\\Aweso\\Verilog\\Aquapack\\bartlett\\sim\\s_theta\\s_%1d.txt",i-1);
	load(mat_file,'result');
    weights(i) = sum((rxx .* result),'all');
	fprintf(fid,"%s\n",weights(i));
    dest = sprintf("s_%1d.txt",i-1);
    copyfile(hex_file,dest);
end
fclose(fid);

plot(1:19, weights, '-o');  % Plot with indices on x-axis

