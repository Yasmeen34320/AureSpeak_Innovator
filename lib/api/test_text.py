import os
from flask import Flask, jsonify, request
from PIL import Image
import pytesseract
import subprocess
# from google.colab.patches import cv2_imshow
import cv2
import numpy as np
#for imgee
from transformers import VisionEncoderDecoderModel, ViTFeatureExtractor, AutoTokenizer
import torch
from PIL import Image
import easyocr
import tempfile

#############
pytesseract.pytesseract.tesseract_cmd = r'C:/Program Files/Tesseract-OCR/tesseract.exe'
print ("runnninggggg")
# Run the command to install tesseract-ocr-ara
#subprocess.run(['sudo', 'apt-get', 'install', 'tesseract-ocr-ara'])
#for imgeee
# Load the model and tokenizer
#####3
app = Flask(__name__)

# # Set the path to Tesseract executable (update this with your actual Tesseract path)
#pytesseract.pytesseract.tesseract_cmd = r'C:/Program Files/Tesseract-OCR/tesseract.exe'
reader = None


import sys
old_stdout = sys.stdout
sys.stdout = open(os.devnull, 'w')  # Suppress progress bar output
reader = easyocr.Reader(['en', 'ar'])  # Specify the languages for OCR
sys.stdout.close()
sys.stdout = old_stdout
print("OCR model loaded successfully")
@app.route('/api/perform_ocr/<language>', methods=['PUT'])
def perform_ocr(language):
    try:
        # Get the image file from the request
        file = request.files['image']

        with tempfile.TemporaryDirectory() as tempdir:
            temp_image_path = os.path.join(tempdir, 'temp_image.png')
            file.save(temp_image_path)
            print(temp_image_path)

            # Perform OCR using EasyOCR
            result = reader.readtext(temp_image_path)

            # Extract the text from the OCR result
            extracted_text = " ".join([text[1] for text in result])

            text = extracted_text

            print(text + ' dddddddddddddddddddddddd')
            print("Sdsd")

            # Return the extracted text
            return jsonify(text)
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/')
def hello():
    return 'Hello, World!'


if __name__ == '__main__':
    app.run(debug=True, port=8000)

