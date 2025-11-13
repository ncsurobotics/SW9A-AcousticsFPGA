function compare(path)
	directory = path;
	% === User settings ===
	mat_file = directory+"\\new_algo_magP.mat";    % .mat file to load
	csv_file = directory+"\\all_result_dec.csv";    % .csv file to load
	img_file = directory+"\\comparison.png";  % output image file
	
	% === Load .mat file ===
	mat_data = load(mat_file);
	
	% If multiple variables exist, grab the first numeric one
	vars = fieldnames(mat_data);
	mat_var = [];
	for k = 1numel(vars)
		if isnumeric(mat_data.(vars{k}))
			mat_var = mat_data.(vars{k});
			break
		end
	end
	
	if isempty(mat_var)
		error('No numeric variable found in %s', mat_file);
	end
	
	% === Load .csv file ===
	csv_data = readmatrix(csv_file)
	
	angle_axis = 0:10:180;

	% === Plot both ===
	figure;
	hold on;
    yyaxis left
	plot(angle_axis,mat_var, 'LineWidth', 2);
    ylabel('Relative Weight');

    yyaxis right
	plot(angle_axis,csv_data, '--', 'LineWidth', 2);
    ylabel('Relative Weight');


	legend({'Modified Oracle','Verilog'});
	xlabel('Angle');

	title(path,'Interpreter','none');
	grid on;
	
	% === Save figure ===
	saveas(gcf, img_file);
	disp(['Saved figure as ', img_file]);
end

