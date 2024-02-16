from flask import Flask, jsonify, request
from PIL import Image
import pytesseract
import subprocess
pytesseract.pytesseract.tesseract_cmd = r'C:/Program Files/Tesseract-OCR/tesseract.exe'

# Run the command to install tesseract-ocr-ara
#subprocess.run(['sudo', 'apt-get', 'install', 'tesseract-ocr-ara'])

app = Flask(__name__)

# # Set the path to Tesseract executable (update this with your actual Tesseract path)
#pytesseract.pytesseract.tesseract_cmd = r'C:/Program Files/Tesseract-OCR/tesseract.exe'

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

if __name__ == '__main__':
    app.run(debug=True)
