import os
import ebooklib
from ebooklib import epub
import pdfkit

def epub_to_pdf(epub_path):
    if not epub_path.endswith('.epub'):
        print("Please provide a path to a valid .epub file.")
        return

    try:
        # Load EPUB file
        book = epub.read_epub(epub_path)
    except Exception as e:
        print(f"Error reading the EPUB file: {e}")
        return

    # Create a temporary directory to store intermediate HTML files
    temp_dir = 'temp_html'
    os.makedirs(temp_dir, exist_ok=True)

    try:
        # Convert each chapter to HTML
        chapter_count = 0
        html_files = []
        for item in book.get_items():
            if isinstance(item, ebooklib.epub.EpubHtml):
                chapter_count += 1
                file_name = f"{chapter_count}.html"
                file_path = os.path.join(temp_dir, file_name)
                html_files.append(f"file:///{os.path.abspath(file_path)}")
                with open(file_path, 'wb') as f:
                    f.write(item.get_body_content())

        # Path to wkhtmltopdf executable
        path_to_wkhtmltopdf = r'C:\Program Files\wkhtmltopdf\bin\wkhtmltopdf.exe'  # Change this to your actual path
        if not os.path.isfile(path_to_wkhtmltopdf):
            raise FileNotFoundError(f"wkhtmltopdf executable not found at: {path_to_wkhtmltopdf}")
        
        config = pdfkit.configuration(wkhtmltopdf=path_to_wkhtmltopdf)

        # Convert HTML files to PDF
        pdf_file_name = os.path.splitext(os.path.basename(epub_path))[0] + '.pdf'
        pdf_file_path = os.path.join(os.path.dirname(epub_path), pdf_file_name)
        pdfkit.from_file(html_files, pdf_file_path, configuration=config)

        print(f"Conversion complete. PDF saved as: {pdf_file_path}")

    except Exception as e:
        print(f"Error during conversion: {e}")

    finally:
        # Clean up temporary HTML files
        for file in os.listdir(temp_dir):
            file_path = os.path.join(temp_dir, file)
            os.remove(file_path)
        os.rmdir(temp_dir)

if __name__ == "__main__":
    epub_path = input("Enter the path to the .epub file: ").strip()
    epub_to_pdf(epub_path)
