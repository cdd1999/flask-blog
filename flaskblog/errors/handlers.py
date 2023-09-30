from flask import Blueprint, render_template
from flaskblog.notifications import notification,friendreq
errors = Blueprint('errors', __name__)

@errors.app_errorhandler(404)
def error_404(error):#pagenot found or server not found
    return render_template('errors/404.html',notifications=notification(),req=friendreq()), 404


@errors.app_errorhandler(403)
def error_403(error):#forbidden error
    return render_template('errors/403.html',notifications=notification(),req=friendreq()), 403
@errors.app_errorhandler(405)
def error_405(error):#method not allowed
    return render_template('errors/405.html',notifications=notification(),req=friendreq()), 405

@errors.app_errorhandler(500)
def error_500(error):#something has gone wrong on web sites server
    return render_template('errors/500.html',notifications=notification(),req=friendreq()), 500
