import os
from flask import Flask, jsonify, request
from PIL import Image
import pytesseract

# pytesseract.pytesseract.tesseract_cmd = r'C:/ME/flutter/test_grad/lib/api/Tesseract-OCR/tesseract.exe' 
# current_dir = os.path.dirname(os.path.abspath(__file__))

# # Set the path to the Tesseract executable relative to the current file
# print(current_dir)
# tesseract_path = os.path.join(current_dir, 'Tesseract-OCR', 'tesseract.exe')
# Set an environment variable
os.environ['TESSERACT_PATH'] ='C:/Program Files/Tesseract-OCR/tesseract.exe'

# Get the value of an environment variable
tesseract_path = os.getenv('TESSERACT_PATH')
pytesseract.pytesseract.tesseract_cmd = tesseract_path
app = Flask(__name__)

@app.route('/api/perform_ocr/<language>', methods=['PUT'])
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
@app.route('/')
def hello():
    return 'Hello, text'
if __name__ == '__main__':
    app.run(debug=True, port=4000)
