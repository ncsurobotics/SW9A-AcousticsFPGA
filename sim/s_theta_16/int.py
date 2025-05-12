 
        
def read_hex_from_file(filename):
    try:
        imag = false
        with open(filename, 'r') as f:
            hex_str = ''
            while True:
                char = f.read(1)
                if not char:
                    break
                if char.strip() == '':
                    continue  # skip whitespace
                hex_str += char
                if len(hex_str) == 2:
                    try:
                        value = int(hex_str, 16)
                        print(value,end = '')
                        if(imag):
                            print('j')
                        else
                            print('')
                            
                        imag = !imag
                    except ValueError:
                        print(f"Invalid hex: '{hex_str}'")
                    hex_str = ''
            if len(hex_str) == 1:
                print(f"Incomplete hex byte at end of file: '{hex_str}'")
    except FileNotFoundError:
        print(f"File '{filename}' not found.")
    except Exception as e:
        print(f"Unexpected error: {e}")

if __name__ == "__main__":
    import sys
    if len(sys.argv) != 2:
        print("Usage: python hex_reader.py <filename>")
    else:
        read_hex_from_file(sys.argv[1])
