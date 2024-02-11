from flask import Flask, jsonify, request
from PIL import Image
import pytesseract

app = Flask(__name__)

# # Set the path to Tesseract executable (update this with your actual Tesseract path)
pytesseract.pytesseract.tesseract_cmd = r'C:/Program Files/Tesseract-OCR/tesseract.exe'

@app.route('/api/perform_ocr', methods=['PUT'])
def perform_ocr():
    try:
        # Get the image file from the request
        file = request.files['image']

        # Save the image to a temporary file (you can customize the path as needed)
        temp_image_path = 'temp_image.png'
        file.save(temp_image_path)

        # Open the image using PIL
        image = Image.open(temp_image_path)

        # Perform OCR using Tesseract
        text = pytesseract.image_to_string(image)

        # Return the extracted text
        return jsonify(text)
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
