import os
import urllib.parse

def generate_html_toc():
    """
    Generate an HTML file as a table of contents for video files in the current directory.
    The output file will be named 'toc.html', formatted in a structured list with working links.
    """
    root_directory = os.getcwd()
    output_file = 'toc.html'
    extensions = ['.mp4', '.avi', '.mov', '.mkv', '.flv', '.wmv']

    html_content = "<!DOCTYPE html>\n<html lang='en'>\n<head>\n<meta charset='UTF-8'>"
    html_content += "\n<title>Table of Contents</title>\n</head>\n<body>\n"
    html_content += "<h1>Table of Contents</h1>\n"

    def list_files_in_directory(subdir, level=0):
        nonlocal html_content
        indent = "&nbsp;" * 4 * level  # HTML indentation for sub-levels
        files_list = sorted([f for f in os.listdir(subdir) if os.path.isfile(os.path.join(subdir, f)) and any(f.endswith(ext) for ext in extensions)])
        dirs_list = sorted([d for d in os.listdir(subdir) if os.path.isdir(os.path.join(subdir, d))])

        for file in files_list:
            file_path = os.path.join(subdir, file)
            relative_file_path = os.path.relpath(file_path, root_directory)
            # Encode the file path for URL
            encoded_file_path = urllib.parse.quote(relative_file_path.replace(os.sep, '/'))
            html_content += f"{indent}<a href='./{encoded_file_path}'>{file}</a><br>\n"

        for d in dirs_list:
            dir_path = os.path.join(subdir, d)
            relative_dir_path = os.path.relpath(dir_path, root_directory)
            html_content += f"{indent}<strong>{d}</strong><br>\n"
            list_files_in_directory(dir_path, level + 1)

    list_files_in_directory(root_directory)

    html_content += "</body>\n</html>"

    with open(output_file, 'w', encoding='utf-8') as file:
        file.write(html_content)

    print(f"HTML TOC created at {os.path.join(root_directory, output_file)}")

generate_html_toc()
