from flaskblog import admin
from flask import redirect,url_for
from flask_admin.contrib.sqla import ModelView
from flask_admin import BaseView,expose
from flask_login import current_user
from flaskblog import db
from flaskblog.models import feedbacks
# if u wanna do for users and posts u have to not include them as blueprints since they get blueprint collison with flask-admin
# flask-admin ensures we can create new entries or delete them instead of doing it from the databse becomes much easier
from datetime import datetime, timedelta
import pygal

class AnalyticsView(BaseView):
    #thw above prints
    @expose('/')
    def index(self):
        graph = pygal.Line()
        graph.title = "% Change Coolness of programming languages over time"
        graph.x_labels = ['2011','2012','2013','2014','2015','2016']
        graph.add('Python',  [15, 31, 89, 200, 356, 900])
        graph.add('Java',    [15, 45, 76, 80,  91,  95])
        graph.add('C++',     [5,  51, 54, 102, 150, 201])
        graph.add('All others combined!',  [5, 15, 21, 55, 92, 105])
        graph_data = graph.render_data_uri()
        return self.render('admin/analytics.html',graph_data=graph_data)
    def is_accessible(self):
        return current_user.username == 'Admin'

    def _handle_view(self, name):
        if not self.is_accessible():
             return redirect(url_for('main.home'))
class NotifyView(BaseView):
    #thw above prints
    @expose('/')
    def index(self):
        positive=db.session.query(feedbacks).filter_by(sentiment='Positive').count()
        negative=db.session.query(feedbacks).filter_by(sentiment='Negative').count()
        return self.render('admin/notify.html',positive=positive,negative=negative)
    def is_accessible(self):
        return current_user.username == 'Admin'

    def _handle_view(self, name):
        if not self.is_accessible():
             return redirect(url_for('main.home'))

class FeedbackView(ModelView):
    column_searchable_list=['fname','message','sentiment']
    column_filters=['sentiment']
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.static_folder = 'static'
    def is_accessible(self):
        return current_user.username == 'Admin'
    def _handle_view(self, name):
        if not self.is_accessible():
            return redirect(url_for('main.home'))

class AdminView(ModelView):
    #column_editable_list
    column_searchable_list=['username','email']
    column_exclude_list = ['password','image_file' ]
    #column_filters=['username']
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.static_folder = 'static'
    def is_accessible(self):
        return current_user.username == 'Admin'
    def _handle_view(self, name):
        if not self.is_accessible():
            return redirect(url_for('main.home'))

'''
class MyModelView(ModelView):
    column_display_pk = True    
    form_columns = ("id", "fname", "lname", "team_name", "nation", "position")

admin.add_view(MyModelView(player, db.session))
'''


