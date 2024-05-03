import os
from flask import Flask, jsonify, request
from PIL import Image
import pytesseract

pytesseract.pytesseract.tesseract_cmd = r'C:/Program Files/Tesseract-OCR/tesseract.exe'

app_ocr = Flask(__name__)

@app_ocr.route('/api/perform_ocr/<language>', methods=['PUT'])
def perform_ocr(language):
    try:
        # Get the image file from the request
        file = request.files['image']
        custom_config = r'--oem 3 --psm 6 -l ara'
        # Save the image to a temporary file (you can customize the path as needed)
        temp_image_path = 'temp_image.png'
        file.save(temp_image_path)

        # Open the image using PIL
        image = Image.open(temp_image_path)
        print(language)
        # Perform OCR using Tesseract
        print("??????????????")
        text = pytesseract.image_to_string(image)

        # if language == 'en':
        #     text = pytesseract.image_to_string(image)
        #     print(text)
        # else:
        #     print("d?????????")
        #     text = pytesseract.image_to_string(image,config=custom_config)
            
        print(text+'dddddddddddddddddddddddd')
        print("Sdsd")

        # Return the extracted text
        return jsonify(text)
    except Exception as e:
        return jsonify({'error': str(e)}), 500
@app_ocr.route('/')
def hello():
    return 'Hello, text'
if __name__ == '__main__':
    app_ocr.run(debug=True, port=8001)
