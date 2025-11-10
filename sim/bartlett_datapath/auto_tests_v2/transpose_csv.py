import os

base_dir = "."

for entry in os.listdir(base_dir):
    subdir_path = os.path.join(base_dir, entry)

    if os.path.isdir(subdir_path):
        file_path = os.path.join(subdir_path, "all_result_dec.csv")

        if os.path.isfile(file_path):
            print(f"Processing: {file_path}")

            # Read entire file as text
            with open(file_path, "r", newline="") as f:
                data = f.read()

            # Replace CRLF (\r\n) with comma+space
            data = data.replace("\r\n", ", ")

            # Write it back
            with open(file_path, "w", newline="") as f:
                f.write(data)

print("✅ Done replacing CRLF with ', ' in all subdirectories.")
