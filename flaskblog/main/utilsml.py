from keras.models import load_model
from keras.preprocessing.image import img_to_array, load_img
from PIL import Image
from flask import current_app
import os


def save_picture(form_picture):
    name = form_picture.filename
    picture_path = os.path.join(current_app.root_path, "static/catsvsdogs", name)

    output_size = (180, 180)
    i = Image.open(form_picture)
    i.thumbnail(output_size)
    i.save(picture_path)
    return picture_path


def load_image(filename):
    # load the image
    img = load_img(filename, target_size=(180, 180))
    # convert to array
    img = img_to_array(img)  # reshape into a single sample with 3 channels
    img = img.reshape(1, 180, 180, 3)
    # center pixel data
    img = img.astype("float32")
    img = img - [123.68, 116.779, 103.939]
    return img


# load an image and predict the class
def run_example(filename):
    # load the image
    img = load_image(filename)
    # load model
    model = load_model("final_model.h5")
    # predict the class
    result = model.predict(img)
    return result[0]
