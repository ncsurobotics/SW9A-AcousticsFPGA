import os
import sys

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
	if len(sys.argv) != 2:
		print("Usage python clear_verilog_products.py PATH")
		exit()
		
	target = sys.argv[1]
	os.chdir(target)
	for file in filenames:
		os.remove(file)
	

if __name__ == "__main__":
	main()