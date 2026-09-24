import os
import re

def reverse_lines_and_remove_newlines(input_file, output_file):
    with open(input_file, 'r') as infile:
        lines = infile.readlines()

    # Reverse line order
    reversed_lines = lines[::-1]

    # Join lines and remove all newline characters
    content = ''.join(reversed_lines).replace('\n', '')

    with open(output_file, 'w') as outfile:
        outfile.write(content)
        
        
def reverse_lines(input_file, output_file):
    with open(input_file, 'r') as infile:
        lines = infile.readlines()

    reversed_lines = lines[::-1]

    with open(output_file, 'w') as outfile:
        outfile.writelines(reversed_lines)
        
        
        
def concatenate_files(directory='.', output_file='temp.txt'):

    with open(output_file, 'w') as outfile:
        for i in range(0,19):
            filename = f"s_{i}_clean.txt"
            file_path = os.path.join(directory, filename)
            with open(file_path, 'r') as infile:
                content = infile.read()
                outfile.write(content)
                outfile.write('\n')


def process_directory(directory='.'):
    pattern = re.compile(r's_(\d+)\.txt$')

    for filename in os.listdir(directory):
        if pattern.match(filename):
            input_path = os.path.join(directory, filename)
            output_filename = filename.replace('.txt', '_clean.txt')
            output_path = os.path.join(directory, output_filename)

            print(f"Processing {filename} -> {output_filename}")
            reverse_lines_and_remove_newlines(input_path, output_path)

if __name__ == "__main__":
    # You can change '.' to any directory you want
    process_directory('.')
    concatenate_files()
    reverse_lines("temp.txt","combined_output.txt")