import re

def insert_multiple_patterns(input_file, output_file, pattern_insert_pairs):
    # Read the original file
    with open(input_file, 'r') as f:
        content = f.read()

    # Apply each pattern and its corresponding insert text
    for pattern, insert_text in pattern_insert_pairs:
        def make_replacer(text):
            return lambda match: text + match.group(0)
        content = re.sub(pattern, make_replacer(insert_text), content)

    # Write the modified content to the output file
    with open(output_file, 'w') as f:
        f.write(content)

    print(f"Modified content written to {output_file}")

# Example usage
if __name__ == "__main__":
    ready_insert = "\t\t<obj_property name=\"CustomSignalColor\">#0000FF</obj_property>\n\t\t<obj_property name=\"UseCustomSignalColor\">true</obj_property>"
    data_insert = "\t\t<obj_property name=\"CustomSignalColor\">#FFFF00</obj_property>\n\t\t<obj_property name=\"UseCustomSignalColor\">true</obj_property>"
    valid_insert = "\t\t<obj_property name=\"CustomSignalColor\">#D900FF</obj_property>\n\t\t<obj_property name=\"UseCustomSignalColor\">true</obj_property>"


    pattern_insert_pairs = [
        (r'<obj_property\sname="ObjectShortName">\w{2,20}tready(?:\[\d*\:\d*\])?<\/obj_property>\n()', ready_insert),
        (r'<obj_property\sname="ObjectShortName">\w{2,20}tdata(?:\[\d*\:\d*\])?<\/obj_property>\n()', data_insert),
        (r'<obj_property\sname="ObjectShortName">\w{2,20}tvalid(?:\[\d*\:\d*\])?<\/obj_property>\n()', valid_insert)
    ]

    insert_multiple_patterns(
        input_file='bartlett_time_domain_tb_behav.wcfg',
        output_file='bartlett_time_domain_tb_behav_colored.wcfg',
        pattern_insert_pairs=pattern_insert_pairs
    )
