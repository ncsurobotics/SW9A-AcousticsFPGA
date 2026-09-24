import os
import csv

INPUT_DIR = "test_data_sweep"
OUTPUT_DIR = "test_data_sweep_normalized"

ADC_MAX = 1023.0

def normalize(x):
    return (float(x) / ADC_MAX) * 2.0 - 1.0

os.makedirs(OUTPUT_DIR, exist_ok=True)

for filename in os.listdir(INPUT_DIR):
    if not filename.lower().endswith(".csv"):
        continue

    in_path = os.path.join(INPUT_DIR, filename)
    out_path = os.path.join(OUTPUT_DIR, filename)

    with open(in_path, newline="") as infile, open(out_path, "w", newline="") as outfile:
        reader = csv.reader(infile)
        writer = csv.writer(outfile)

        for row in reader:
            normalized = [f"{normalize(v):.6f}" for v in row]
            writer.writerow(normalized)

    print(f"Converted {filename}")

print("\nAll CSVs normalized.")
