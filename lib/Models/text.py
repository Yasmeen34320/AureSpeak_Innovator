# !sudo apt-get install tesseract-ocr
# !pip install pytesseract


from PIL import Image
import pytesseract


image_path = 'D:/vs code/flutter/grd_project/grd_projecttt/lib/assest/IvV2y.png'


image = Image.open(image_path)

text = pytesseract.image_to_string(image)


print(text)