import os
import secrets
from PIL import Image
from flask import url_for, current_app
from flask_mail import Message
from flaskblog import mail
from threading import Thread

def save_picture(form_picture):
    random_hex = secrets.token_hex(8) # get random hex to add to picture 
    _, f_ext = os.path.splitext(form_picture.filename)
    picture_fn = random_hex + f_ext
    picture_path = os.path.join(current_app.root_path, 'static/profile_pics', picture_fn)

    output_size = (125, 125)
    i = Image.open(form_picture)
    i.thumbnail(output_size)
    i.save(picture_path)

    return picture_fn

def async_send_mail(msg):
    mail.send(msg)

def send_reset_email(user):
    token = user.get_reset_token()
    '''
    with app.open_resource("image.png") as fp:
    msg.attach("image.png", "image/png", fp.read())
    '''
    msg = Message('Password Reset Request',
                  sender='noreply@demo.com',
                  recipients=[user.email])
    # u can also use msg.html=render_template and so on
    msg.body = f'''To reset your password, visit the following link:
{url_for('usersroute.reset_token', token=token, _external=True)}
If you did not make this request then simply ignore this email and no changes will be made.
'''
    
    thr = Thread(target=async_send_mail, args=[msg])#async_sen_email sends the email
    # this ensures that after submitting we receive a message email has been sent and not wait till mail has been actually delivered which causes delay
    thr.start()
    return thr