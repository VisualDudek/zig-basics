import os
import re

def traverse_and_extract():
    # Regex pattern for matching file names
    file_pattern = re.compile(r'^0(?:0\d|\d\d).*\.zig$')
    
    # List to store the extracted lines
    extracted_lines = []
    
    # Traverse files in the current directory
    for filename in os.listdir('.'):
        if file_pattern.match(filename):
            try:
                with open(filename, 'r') as file:
                    first_line = file.readline().strip()
                    if first_line.startswith('//'):
                        extracted_lines.append(f"## {filename}")
                        extracted_lines.append(f"```txt")
                        extracted_lines.append(f"{first_line}")

                        next_line = file.readline().strip()
                        while (next_line.startswith('//')):
                            extracted_lines.append(f"{next_line}")
                            next_line = file.readline().strip()
                        # last line, add line-feed
                        extracted_lines.append(f"```")
                        extracted_lines.append(f"")

            except IOError as e:
                print(f"Error reading file {filename}: {e}")
    
    # Write extracted lines to output file
    with open('README.md', 'w') as output_file:
        for line in extracted_lines:
            output_file.write(line + '\n')

if __name__ == "__main__":
    traverse_and_extract()
    print("Extraction complete. Results written to 'README.md'.")
