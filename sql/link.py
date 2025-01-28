import os
import re
from pathlib import Path

def read_sql_file(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            return f.read()
    except FileNotFoundError:
        print(f"Warning: File not found: {file_path}")
        return f"-- Missing file: {file_path}"

def process_includes(content, base_path):
    include_pattern = r'\\i\s+[\'"]?([^\'"\n]+)[\'"]?'
    
    def replace_include(match):
        include_file = match.group(1)
        include_path = os.path.join(base_path, include_file)
        included_content = read_sql_file(include_path)
        return process_includes(included_content, os.path.dirname(include_path))
    
    return re.sub(include_pattern, replace_include, content)

def combine_sql_files(input_file):
    input_path = Path(input_file)
    base_path = input_path.parent
    output_path = base_path / f"{input_path.stem}_combined{input_path.suffix}"

    content = read_sql_file(input_file)
    combined_content = process_includes(content, base_path)

    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(combined_content)
    
    print(f"Combined SQL written to: {output_path}")

if __name__ == '__main__':
    import sys
    if len(sys.argv) != 2:
        print("Usage: python sql_combiner.py <input_sql_file>")
        sys.exit(1)
    
    combine_sql_files(sys.argv[1])