function compare_fourier(path)
	directory = path;
    %directory = "test_11_32_60_5";
	% === User settings ===
	mag_oracle_file = directory+"\\oracle_mag_fft.mat";    % .mat file to load
	mag_verilog_file = directory+"\\mag_fft_dec.csv";
	mag_img_file = directory+"\\mag_fft_comparison.png";  % output image file
    oracle_file = directory+"\\oracle_fft.mat";    % .mat file to load
	verilog_file = directory+"\\raw_fft_dec.csv";
    img_file = directory+"\\fft_comparison.png";  % output image file
	
	% === Load .mat file ===
	mag_oracle_data = load(mag_oracle_file);
    	% If multiple variables exist, grab the first numeric one
	vars = fieldnames(mag_oracle_data);
	mag_oracle_var = [];
	for k = 1numel(vars)
		if isnumeric(mag_oracle_data.(vars{k}))
			mag_oracle_var = mag_oracle_data.(vars{k});
			break
		end
	end

    	% === Load .mat file ===
	oracle_data = load(oracle_file);
    	% If multiple variables exist, grab the first numeric one
	vars = fieldnames(oracle_data);
	oracle_var = [];
	for k = 1numel(vars)
		if isnumeric(oracle_data.(vars{k}))
			oracle_var = oracle_data.(vars{k});
			break
		end
	end

	
	% === Load matrix file ===
	mag_verilog_data = readmatrix(mag_verilog_file);
	verilog_data = readmatrix(verilog_file);

	k = -128:1:127;
    mag_figure = figure;
    for i = 1:1:1
	    % === Plot both ===
	    hold on;
        yyaxis left
	    plot(k,mag_oracle_var(1,:), 'LineWidth', 2);
        ylabel('Power');
    
        yyaxis right
	    plot(k,mag_verilog_data, 'LineWidth', 2);
        ylabel('Power');
    
    
	    legend({'Oracle','Verilog'});
	    xlabel('Frequency index');
    
        
	    title(directory,sprintf("Channel %d",i));
	    grid on;
	    

    end
    % === Save figure ===
	saveas(mag_figure, mag_img_file);
	disp(['Saved figure as ', mag_img_file]);
    k = 0:1:127;
    fft_figure = figure;
    for i = 1:1:4
	    % === Plot both ===
	    subplot(2,4,i)
	    hold on;
        yyaxis left
	    plot(k,real(oracle_var(i,k+128)), 'LineWidth', 2);
        ylabel('Power');
    
        yyaxis right
	    plot(k,verilog_data(i,k+128),  'LineWidth', 2);
        ylabel('Power');
    
    
	    xlabel('Frequency index');
    
        
	    title(directory,sprintf("Channel %d Real",i));
	    grid on;

        	    % === Plot both ===
	    subplot(2,4,i+4)
	    hold on;
        yyaxis left
	    plot(k,imag(oracle_var(i,k+128)), 'LineWidth', 2);
        ylabel('Power');
    
        yyaxis right
	    plot(k,verilog_data(i+1,k+128), 'LineWidth', 2);
        ylabel('Power');
    
    
	    xlabel('Frequency index');
    
        
	    title(directory,sprintf("Channel %d Imaginary",i));
	    grid on;
	    
	    

    end
    % === Save figure ===
	saveas(fft_figure, img_file);
	disp(['Saved figure as ', img_file]);
end