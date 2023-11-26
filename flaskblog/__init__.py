from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_login import LoginManager
from flask_mail import Mail
from flaskblog.config import (
    Config,
)  # goes to config page for database, mail , username stuff
from flask_socketio import SocketIO
from flask_admin import Admin
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address

# classes created
db = SQLAlchemy()  # database created
socketio = SocketIO()
admin=Admin(base_template="layout.html",template_mode='bootstrap3')
#admin=Admin(name='Dashboard', index_view=AdminView(Users, db.session, url='/admin', endpoint='admin'))
bcrypt = Bcrypt()
login_manager = LoginManager()  # does not support user eg or account recovery
# handles log in and out / remember me part / protect user sessions from being stolen by cookie thieves
limiter = Limiter(key_func=get_remote_address,
    default_limits=["700 per day", "350 per hour"])
login_manager.login_view = "users.login"  # if not there then 401 error
login_manager.login_message_category = "info"
mail = Mail()


def create_app(config_class=Config):
    app = Flask(__name__)  # creating an app
    app.config.from_object(Config)
    socketio.init_app(app)
    db.init_app(app)
    
    admin.init_app(app)
    limiter.init_app(app)
    
    bcrypt.init_app(app)
    login_manager.init_app(app)
    mail.init_app(app)
    app.app_context().push()
    with app.app_context():
        from flaskblog.usersroute.routes import usersroute
        from flaskblog.posts.routes import posts
        from flaskblog.main.routes import main
        from flaskblog.errors.handlers import errors
        from flaskblog.stat.routes import stat

        app.register_blueprint(usersroute)
        app.register_blueprint(posts)
        app.register_blueprint(main)
        app.register_blueprint(stat)
        app.register_blueprint(errors)

    return app
