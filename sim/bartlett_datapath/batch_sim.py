import os

# directory path
directory = "test_data"
bit_width = 32
i = 0
# loop through all files in the directory
for filename in os.listdir(directory):
	filepath = os.path.join(directory, filename)

	# check if it's a file (not a folder)
	if os.path.isfile(filepath):
		degrees = filename.split('_')[3].replace('deg','')
		iter = filename.split('_')[4].replace('.csv','')
		test_name = f"py_test_{i}_{bit_width}_{degrees}_{iter}"
		os.system(f"sim.bat {test_name} {filepath}")
		
		
	i = i + 1
		
