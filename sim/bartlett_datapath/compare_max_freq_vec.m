function compare_max_freq_vec(path)
	directory = path;
    %directory = "test_11_32_60_5";
	% === User settings ===
	mat_file = directory+"\\oracle_max_freq.csv";    % .mat file to load
	csv_file = directory+"\\max_freq_vec.csv";    % .csv file to load
	img_file = directory+"\\max_freq_vec_comparison.png";  % output image file
	
	% === Load .mat file ===
	mat_data =  readmatrix(mat_file)
	% === Load .csv file ===
	csv_data = readmatrix(csv_file)

    index = 1:1:4
	% === Plot both ===
	figure;
    subplot(2,1,1)
	hold on;
    yyaxis left
	plot(index,mat_data(:,1), 'LineWidth', 2);
    ylabel('Oracle Relative Weight');

    yyaxis right
	plot(index,csv_data(:,1), '--', 'LineWidth', 2);
    ylabel('Verilog Relative Weight');


	legend({'Oracle','Verilog'});
	xlabel('Index');

	title(directory,'Real');
	grid on;
	
    subplot(2,1,2)
	hold on;
    yyaxis left
	plot(index,mat_data(:,2), 'LineWidth', 2);
    ylabel('Oracle Relative Weight');

    yyaxis right
	plot(index,csv_data(:,2), '--', 'LineWidth', 2);
    ylabel('Verilog Relative Weight');


	legend({'Oracle','Verilog'});
	xlabel('Index');

	title(directory,'Imag');
	grid on;
	
	% === Save figure ===
	saveas(gcf, img_file);
	disp(['Saved figure as ', img_file]);
end