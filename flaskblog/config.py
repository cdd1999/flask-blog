import os


class Config:
    SECRET_KEY = os.environ.get('secretKey')
    SQLALCHEMY_DATABASE_URI = os.environ.get('databaseUri')
    #os.environ.get
    MAIL_SERVER = 'sandbox.smtp.mailtrap.io'
    MAIL_PORT = 2525
    MAIL_USERNAME = '86f9943eb8ec59'
    MAIL_PASSWORD = 'fd9703a23e79aa'
    MAIL_USE_TLS = True
    MAIL_USE_SSL = False
'''
    Hooking in WSGI Middleware¶
To add WSGI middleware to your Flask application, wrap the application’s wsgi_app attribute. 
For example, to apply Werkzeug’s ProxyFix middleware for running behind Nginx:

from werkzeug.middleware.proxy_fix import ProxyFix
app.wsgi_app = ProxyFix(app.wsgi_app)
Wrapping app.wsgi_app instead of app means that app still points at your Flask application, 
not at the middleware, so you can continue to use and configure app directly.
'''