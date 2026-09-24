function compare_rxx(path)
	directory = path;
	% === User settings ===
	mat_file = directory+"\\oracle_rxx.csv";    % .mat file to load
	csv_file = directory+"\\rxx_dec.csv";    % .csv file to load
	img_file = directory+"\\rxx_comparison.png";  % output image file
	
	% === Load .mat file ===
	mat_data =  readmatrix(mat_file)
	% === Load .csv file ===
	csv_data = readmatrix(csv_file)

    index = 0:1:15
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

	title(path,'Real');
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

	title(path,'Imag');
	grid on;
	
	% === Save figure ===
	saveas(gcf, img_file);
	disp(['Saved figure as ', img_file]);
end