

from PIL import Image

import easyocr

def extract_text_easyocr(image_path, languages=['en']):
    reader = easyocr.Reader(languages)  # Specify languages for OCR
    image = Image.open(image_path)

    # Perform OCR on the image
    result = reader.readtext(image_path)

    extracted_text = ""
    for detection in result:
        text = detection[1]
        extracted_text += text + " "

    return extracted_text

# Example usage   ,,,, ,,  ,, /content/images.png
image_path = "C:/Users/PC/Downloads/image/download.png"
extracted_text = extract_text_easyocr(image_path, languages=['en', 'ar'])  # Add 'ar' for Arabic

with open('extracted_text.txt', 'w', encoding='utf-8') as file:
    file.write(extracted_text)