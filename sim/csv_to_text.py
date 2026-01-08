import csv
import sys

NUM_BITS = 10
MAX_VAL = (1 << (NUM_BITS - 1)) - 1  # 511
MIN_VAL = -(1 << (NUM_BITS - 1))	 # -512

def float_to_10bit_hex(x):
	# Scale
	val = int(round(x * MAX_VAL))

	# Clamp
	val = max(MIN_VAL, min(MAX_VAL, val))

	# Two's complement for negative values
	if val < 0:
		val = (1 << NUM_BITS) + val

	# Return zero-padded hex (10 bits = 3 hex digits)
	return f"{val:03X}"



if __name__ == "__main__":
	if len(sys.argv) != 3:
		print("USAGE: python csv_to_text.py INPUT_CSV OUTPUT_PATH")
		exit()
	INPUT_CSV = sys.argv[1]
	OUTPUT_PATH = sys.argv[2]
	# Read CSV
	with open(INPUT_CSV, newline="") as csvfile:
		reader = csv.reader(csvfile)
		rows = [[float(x) for x in row] for row in reader]
	
	with open(f"{OUTPUT_PATH}/src_path.txt","w") as f:
		f.write(INPUT_CSV)
	
	# Write each row to its own file
	for i, row in enumerate(rows):
		with open(f"{OUTPUT_PATH}/ADC{i+1}_samples.txt", "w") as f:
			for x in row:
				f.write(float_to_10bit_hex(x) + "\n")
	
	print("Done.")
