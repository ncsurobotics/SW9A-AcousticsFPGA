% Define matrix size
rows = 4;
cols = 256;

s_0 	= load("C:\Users\Aweso\Verilog\Aquapack\bartlett\sim\s_theta\s_0.mat","result"); 
s_1 	= load("C:\Users\Aweso\Verilog\Aquapack\bartlett\sim\s_theta\s_1.mat","result"); 
s_2 	= load("C:\Users\Aweso\Verilog\Aquapack\bartlett\sim\s_theta\s_2.mat","result"); 
s_3 	= load("C:\Users\Aweso\Verilog\Aquapack\bartlett\sim\s_theta\s_3.mat","result"); 
s_4 	= load("C:\Users\Aweso\Verilog\Aquapack\bartlett\sim\s_theta\s_4.mat","result"); 
s_5 	= load("C:\Users\Aweso\Verilog\Aquapack\bartlett\sim\s_theta\s_5.mat","result");
s_6 	= load("C:\Users\Aweso\Verilog\Aquapack\bartlett\sim\s_theta\s_6.mat","result");  
s_7 	= load("C:\Users\Aweso\Verilog\Aquapack\bartlett\sim\s_theta\s_7.mat","result");  
s_8 	= load("C:\Users\Aweso\Verilog\Aquapack\bartlett\sim\s_theta\s_8.mat","result");  
s_9 	= load("C:\Users\Aweso\Verilog\Aquapack\bartlett\sim\s_theta\s_9.mat","result");  
s_10 	= load("C:\Users\Aweso\Verilog\Aquapack\bartlett\sim\s_theta\s_10.mat","result"); 
s_11 	= load("C:\Users\Aweso\Verilog\Aquapack\bartlett\sim\s_theta\s_11.mat","result");  
s_12 	= load("C:\Users\Aweso\Verilog\Aquapack\bartlett\sim\s_theta\s_12.mat","result");  
s_13 	= load("C:\Users\Aweso\Verilog\Aquapack\bartlett\sim\s_theta\s_13.mat","result");  
s_14 	= load("C:\Users\Aweso\Verilog\Aquapack\bartlett\sim\s_theta\s_14.mat","result");  
s_15 	= load("C:\Users\Aweso\Verilog\Aquapack\bartlett\sim\s_theta\s_15.mat","result");
s_16 	= load("C:\Users\Aweso\Verilog\Aquapack\bartlett\sim\s_theta\s_16.mat","result");
s_17 	= load("C:\Users\Aweso\Verilog\Aquapack\bartlett\sim\s_theta\s_17.mat","result");
s_18 	= load("C:\Users\Aweso\Verilog\Aquapack\bartlett\sim\s_theta\s_18.mat","result");


% Generate random complex numbers
real_part = randi([-1000,1000], rows, cols); %randi([-32768, 32767], rows, cols); % 16-bit signed integers
imag_part = randi([-1000,1000], rows, cols); %randi([-32768, 32767], rows, cols);
matrix = complex(real_part, imag_part);

rxx = ((matrix * matrix')/256);

filename2 = "matlab_rxx_dec.txt"
filename1 = "matlab_rxx_hex.txt"
fid1 = fopen(filename1,'w')
fid2 = fopen(filename2,'w')
% Loop through each row and save to a separate file
for i = 1:rows    
    for j = 1:rows
		rxx_r = real(rxx(i, j));
		rxx_i = imag(rxx(i, j));
        real_hex = dec2hex(typecast(int32(rxx_r), 'int32'), 8); % Convert real part to hex
        imag_hex = dec2hex(typecast(int32(rxx_i), 'int32'), 8); % Convert imag part to hex
        fprintf(fid1, '%s%s\n', imag_hex, real_hex); % Write to file
		fprintf(fid2,'%d + j%d\t\n',rxx_r,rxx_i);
    end
    
end
fclose(fid1);
fclose(fid2);

matlab_result_0  = sum((rxx .* s_0.result),"all")
matlab_result_1  = sum((rxx .* s_1.result),"all")
matlab_result_2  = sum((rxx .* s_2.result),"all")
matlab_result_3  = sum((rxx .* s_3.result),"all")
matlab_result_4  = sum((rxx .* s_4.result),"all")
matlab_result_5  = sum((rxx .* s_5.result),"all")
matlab_result_6  = sum((rxx .* s_6.result),"all")
matlab_result_7  = sum((rxx .* s_7.result),"all")
matlab_result_8  = sum((rxx .* s_8.result),"all")
matlab_result_9  = sum((rxx .* s_9.result),"all")
matlab_result_10 = sum((rxx .* s_10.result),"all")
matlab_result_11 = sum((rxx .* s_11.result),"all")
matlab_result_12 = sum((rxx .* s_12.result),"all")
matlab_result_13 = sum((rxx .* s_13.result),"all")
matlab_result_14 = sum((rxx .* s_14.result),"all")
matlab_result_15 = sum((rxx .* s_15.result),"all")
matlab_result_16 = sum((rxx .* s_16.result),"all")
matlab_result_17 = sum((rxx .* s_17.result),"all")
matlab_result_18 = sum((rxx .* s_18.result),"all")

% Loop through each row and save to a separate file
for i = 1:rows
    filename = sprintf('channel%1d.txt', i); % Create file name (e.g., row_001.txt)
    fid = fopen(filename, 'w'); % Open file for writing
    
    for j = 1:cols
        real_hex = dec2hex(typecast(int32(real_part(i, j)), 'int32'), 8); % Convert real part to hex
        imag_hex = dec2hex(typecast(int32(imag_part(i, j)), 'int32'), 8); % Convert imag part to hex
        fprintf(fid, '%s%s\n', imag_hex, real_hex); % Write to file
    end
    
    fclose(fid); % Close file
end

fid2 = fopen("matlab_result.txt",'w');

fprintf(fid2,"%d\n",matlab_result_0 );
fprintf(fid2,"%d\n",matlab_result_1 );
fprintf(fid2,"%d\n",matlab_result_2 );
fprintf(fid2,"%d\n",matlab_result_3 );
fprintf(fid2,"%d\n",matlab_result_4 );
fprintf(fid2,"%d\n",matlab_result_5 );
fprintf(fid2,"%d\n",matlab_result_6 );
fprintf(fid2,"%d\n",matlab_result_7 );
fprintf(fid2,"%d\n",matlab_result_8 );
fprintf(fid2,"%d\n",matlab_result_9 );
fprintf(fid2,"%d\n",matlab_result_10);
fprintf(fid2,"%d\n",matlab_result_11);
fprintf(fid2,"%d\n",matlab_result_12);
fprintf(fid2,"%d\n",matlab_result_13);
fprintf(fid2,"%d\n",matlab_result_14);
fprintf(fid2,"%d\n",matlab_result_15);
fprintf(fid2,"%d\n",matlab_result_16);
fprintf(fid2,"%d\n",matlab_result_17);
fprintf(fid2,"%d\n",matlab_result_18);

fclose(fid2);
