import os
import sys

def trim_csv(file_path):
    with open(file_path, "rb") as f:
        data = f.read()
    # Strip trailing newlines/spaces
    trimmed = data.rstrip(b"\n \t")
    if trimmed != data:
        with open(file_path, "wb") as f:
            f.write(trimmed)
        print(f"Fixed: {file_path}")
    else:
        print(f"No change: {file_path}")
		
	

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python fix_csv.py file1.csv [file2.csv ...]")
        sys.exit(1)

    for file in sys.argv[1:]:
        trim_csv(file)
