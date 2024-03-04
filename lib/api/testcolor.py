#from google.colab.patches import cv2_imshow
import cv2
import numpy as np

input_img = cv2.imread("D:/vs code/flutter/grd_project/grd_projecttt/lib/assest/3.jpg")
img = cv2.resize(input_img, (640, 480))

# Make a copy to draw contour outline
input_image_cpy = img.copy()

hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)

# Define color ranges for twenty-one colors
color_ranges = {
    'Red': ([0, 50, 50], [10, 255, 255]),
    'Green': ([40, 20, 50], [90, 255, 255]),
    'Blue': ([100, 50, 50], [130, 255, 255]),
    'Yellow': ([20, 100, 100], [30, 255, 255]),
    'Purple': ([130, 50, 50], [160, 255, 255]),
    'Orange': ([10, 100, 100], [20, 255, 255]),
    'Cyan': ([85, 100, 100], [105, 255, 255]),
    'Magenta': ([160, 100, 100], [180, 255, 255]),
    'Pink': ([140, 50, 50], [160, 255, 255]),
    'Brown': ([0, 50, 10], [30, 255, 120]),
    'Lime': ([50, 50, 50], [70, 255, 255]),
    'Teal': ([80, 50, 50], [100, 255, 255]),
    'Olive': ([30, 50, 50], [50, 255, 255]),
    'Maroon': ([0, 50, 50], [10, 255, 120]),
    'Navy': ([100, 50, 50], [130, 255, 120]),
    'Turquoise': ([70, 100, 100], [90, 255, 255]),
    'Violet': ([130, 50, 50], [160, 255, 120]),
    'Indigo': ([90, 50, 50], [110, 255, 120]),
    'Beige': ([20, 50, 120], [30, 150, 255]),
    'Mint': ([50, 50, 120], [70, 150, 255]),
    'Black': ([0, 0, 0], [180, 255, 30]),
}

# Function to get the bounding box area
def get_contour_area(contour):
    x, y, w, h = cv2.boundingRect(contour)
    return w * h

# Initialize variables to track the largest object
largest_object_area = 0
largest_object_color = None
largest_object_coordinates = None

# Function to update the largest object information
def update_largest_object(contour, color):
    global largest_object_area, largest_object_color, largest_object_coordinates
    contour_area = get_contour_area(contour)
    if contour_area > largest_object_area:
        largest_object_area = contour_area
        largest_object_color = color
        largest_object_coordinates = cv2.boundingRect(contour)

# Loop through each color range
for color, (lower, upper) in color_ranges.items():
    mask = cv2.inRange(hsv, np.array(lower), np.array(upper))
    contours, _ = cv2.findContours(mask, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

    # Loop through the contours and find the largest object for each color
    for cnt in contours:
        contour_area = get_contour_area(cnt)
        if contour_area > 1000:  # You can adjust the area threshold as needed
            update_largest_object(cnt, color)

# If an object is detected, draw a rectangle and display color name
if largest_object_area > 0:
    x, y, w, h = largest_object_coordinates
    cv2.rectangle(img, (x, y), (x + w, y + h), (0, 255, 0), 2)
    cv2.putText(img, largest_object_color, (x, y - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.9, (0, 255, 0), 2)
    #print(f"Detected the largest {largest_object_color} object at coordinates (x:{x}, y:{y})")
    print (largest_object_color)
else:
    print("No object detected")
