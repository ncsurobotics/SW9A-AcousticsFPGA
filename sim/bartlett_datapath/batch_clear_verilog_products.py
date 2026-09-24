import os
import sys
import time

def psys(command):
	print(command)
	os.system(command)
	
filenames = [
"mid_matrix.csv" ,
"max_freq_vec.csv" ,
"fft_max_index.txt" ,
"raw_fft_dec.csv" ,
"mag_fft_dec.csv" ,
"raw_fft_hex.txt" ,
"rxx_dec.csv" ,
"rxx_dec.txt" ,
"rxx_hex.txt" ,
"all_result_dec.csv" ,
"max_result_dec.txt" ,
"all_result_dec.txt" ,
"max_result_hex.txt" ,
"all_result_hex.txt" 
]

def main():
	folder = "auto_tests"
	for directory in os.listdir(folder):
		dir_path = os.path.join(folder, directory)
		if os.path.isdir(dir_path):
			for file in filenames:
				file_path = os.path.join(dir_path, file)
				if os.path.exists(file_path):
					if sys.argv[1] == 'remove':
						os.remove(file_path)
						print(f"removed {file_path}")
					else:
						print(file_path)



if __name__ == "__main__":
	main()