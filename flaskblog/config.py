import os


class Config:
    
    #app.config['SECRET_KEY'] = '5791628bb0b13ce0c676dfde280ba245'
    #app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///site.db' 
    #if u wanna use sqlite which gives u local file no nee for app context
    
    SECRET_KEY = 'SECRET_KEY'#os.environ.get('SECRET_KEY')
    SQLALCHEMY_DATABASE_URI = "postgresql://postgres:cdd1999@localhost:5432/flask"#os.environ.get('SQLALCHEMY_DATABASE_URI')
    #environ.get values have to be put in evironment variables
    MAIL_SERVER = 'smtp.gmail.com'
    MAIL_PORT = 587
    MAIL_USE_TLS = True
    MAIL_USERNAME = os.environ.get('EMAIL_USER')
    MAIL_PASSWORD = os.environ.get('EMAIL_PASS')
'''
    Hooking in WSGI Middleware¶
To add WSGI middleware to your Flask application, wrap the application’s wsgi_app attribute. 
For example, to apply Werkzeug’s ProxyFix middleware for running behind Nginx:

from werkzeug.middleware.proxy_fix import ProxyFix
app.wsgi_app = ProxyFix(app.wsgi_app)
Wrapping app.wsgi_app instead of app means that app still points at your Flask application, 
not at the middleware, so you can continue to use and configure app directly.
'''