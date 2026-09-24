import os
import sys
import time

def psys(command):
	print(command)
	os.system(command)


def main():
	folder = "auto_tests"
	index = 0
	here = "C:\\Users\\Aweso\\Verilog\\Aquapack\\bartlett\\sim\\bartlett_datapath"
	tb_file = here + "\\bartlett_datapath_tb_auto.v"
	namepy = here + "\\naming.py"
	for filename in os.listdir(folder):
		file_path = os.path.join(folder, filename)
		test_name = file_path.split('\\')[1]
		file_path = here + "\\" + file_path
		os.chdir("C:\\Users\\Aweso\\Verilog\\Aquapack\\bartlett\\bartlett.sim\\sim_1\\behav\\xsim")		
		if os.path.isdir(file_path):
			psys(f"python {namepy} {tb_file} {tb_file} $TEST_NAME$ {test_name}")
			psys("compile.bat")
			psys("elaborate.bat")
			psys("simulate.bat")
			psys(f"python {namepy} {tb_file} {tb_file} {test_name} $TEST_NAME$")
			#if "all_result_dec.csv" in os.listdir(file_path):
				#print("This one is done")







if __name__ == "__main__":
	main()