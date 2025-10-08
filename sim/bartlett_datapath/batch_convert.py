import os
import sys

def psys(command):
	print(command)


def main():

	folder = "test_data"
	index = 0
	matlab_script = "matlab -batch "
	for filename in os.listdir(folder):
		file_path = os.path.join(folder, filename)
		if os.path.isfile(file_path):
			degree = filename.split('deg')[0].split('data_')[1]
			test_iter = filename.split('.csv')[0].split('deg_')[1]
			testname = f"test_{index}_32_{degree}_{test_iter}"
			testdir = f"auto_tests/{testname}"
			#os.mkdir(testdir)
			psys(f"cp {file_path} {testdir}/data.csv")
			psys(f"./csv_to_hex.exe {testdir}/data.csv {testdir}/data.hex")
			matlab_script += f"oracle({testdir}); "
			
		index += 1
		
	psys(matlab_script)







if __name__ == "__main__":
	main()