% Define matrix size
rows = 4;
cols = 256;

s_0 	= ones(4); 
s_1 	= ones(4); 
s_2 	= ones(4); 
s_3 	= ones(4); 
s_4 	= ones(4); 
s_5 	= ones(4);
s_6 	= ones(4); 
s_7 	= ones(4); 
s_8 	= ones(4); 
s_9 	= ones(4); 
s_10 	= ones(4); 
s_11 	= ones(4); 
s_12 	= ones(4); 
s_13 	= ones(4); 
s_14 	= ones(4); 
s_15 	= ones(4); 

% Generate random complex numbers
real_part = randi([-200,200], rows, cols) %randi([-32768, 32767], rows, cols); % 16-bit signed integers
imag_part = randi([-200,200], rows, cols) %randi([-32768, 32767], rows, cols);
matrix = complex(real_part, imag_part);

rxx = ((matrix * matrix')/256);

matlab_result_0  = sum((rxx .* s_0 ),"all");
matlab_result_1  = sum((rxx .* s_1 ),"all");
matlab_result_2  = sum((rxx .* s_2 ),"all");
matlab_result_3  = sum((rxx .* s_3 ),"all");
matlab_result_4  = sum((rxx .* s_4 ),"all");
matlab_result_5  = sum((rxx .* s_5 ),"all");
matlab_result_6  = sum((rxx .* s_6 ),"all");
matlab_result_7  = sum((rxx .* s_7 ),"all");
matlab_result_8  = sum((rxx .* s_8 ),"all");
matlab_result_9  = sum((rxx .* s_9 ),"all");
matlab_result_10 = sum((rxx .* s_10),"all");
matlab_result_11 = sum((rxx .* s_11),"all");
matlab_result_12 = sum((rxx .* s_12),"all");
matlab_result_13 = sum((rxx .* s_13),"all");
matlab_result_14 = sum((rxx .* s_14),"all");
matlab_result_15 = sum((rxx .* s_15),"all");

% Loop through each row and save to a separate file
for i = 1:rows
    filename = sprintf('channel%1d.txt', i); % Create file name (e.g., row_001.txt)
    fid = fopen(filename, 'w'); % Open file for writing
    
    for j = 1:cols
        real_hex = dec2hex(typecast(int32(real_part(i, j)), 'int16'), 4); % Convert real part to hex
        imag_hex = dec2hex(typecast(int32(imag_part(i, j)), 'int16'), 4); % Convert imag part to hex
        fprintf(fid, '%s%s\n', imag_hex, real_hex); % Write to file
    end
    
    fclose(fid); % Close file
end

fid = fopen("matlab_result.txt");

fprintf(fid,"%s",matlab_result_0 );
fprintf(fid,"%s",matlab_result_1 );
fprintf(fid,"%s",matlab_result_2 );
fprintf(fid,"%s",matlab_result_3 );
fprintf(fid,"%s",matlab_result_4 );
fprintf(fid,"%s",matlab_result_5 );
fprintf(fid,"%s",matlab_result_6 );
fprintf(fid,"%s",matlab_result_7 );
fprintf(fid,"%s",matlab_result_8 );
fprintf(fid,"%s",matlab_result_9 );
fprintf(fid,"%s",matlab_result_10);
fprintf(fid,"%s",matlab_result_11);
fprintf(fid,"%s",matlab_result_12);
fprintf(fid,"%s",matlab_result_13);
fprintf(fid,"%s",matlab_result_14);
fprintf(fid,"%s",matlab_result_15);

fclose(fid);

