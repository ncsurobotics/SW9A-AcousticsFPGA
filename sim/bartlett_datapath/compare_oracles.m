function compare_oracles(path)
	directory = path;
	% === User settings ===
	original_mat_file = directory+"\\magP.mat";    % .mat file to load
	modified_mat_file = directory+"\\new_algo_magP.mat";
	img_file = directory+"\\oracles_comparison.png";  % output image file
	
	% === Load .mat file ===
	originaL_mat_data = load(original_mat_file);
	
	% If multiple variables exist, grab the first numeric one
	vars = fieldnames(originaL_mat_data );
	original_mat_var = [];
	for k = 1numel(vars)
		if isnumeric(originaL_mat_data .(vars{k}))
			original_mat_var  = originaL_mat_data .(vars{k});
			break
		end
	end
	
	if isempty(original_mat_var )
		error('No numeric variable found in %s', original_mat_file);
	end
	
	% === Load .mat file ===
	modified_mat_data = load(modified_mat_file);
	
	% If multiple variables exist, grab the first numeric one
	vars = fieldnames(modified_mat_data );
	modified_mat_var = [];
	for k = 1numel(vars)
		if isnumeric(modified_mat_data .(vars{k}))
			modified_mat_var  = modified_mat_data .(vars{k});
			break
		end
	end
	
	if isempty(modified_mat_var )
		error('No numeric variable found in %s', modified_mat_file);
	end
	
	angle_axis = 0:10:180;

	% === Plot both ===
	figure;
	hold on;
    yyaxis left
	plot(angle_axis,original_mat_var, 'LineWidth', 2);
    ylabel('Relative Weight');

    yyaxis right
	plot(angle_axis,modified_mat_var, '--', 'LineWidth', 2);
    ylabel('Relative Weight');


	legend({'Original Oracle','Modified Oracle'});
	xlabel('Angle');

	title(path,'Interpreter','none');
	grid on;
	
	% === Save figure ===
	saveas(gcf, img_file);
	disp(['Saved figure as ', img_file]);
end