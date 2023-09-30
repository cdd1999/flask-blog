from flaskblog import db,admin
from flaskblog.main.admin import AdminView,FeedbackView,NotifyView,AnalyticsView
from flaskblog.models import Posts, league, nationality,feedbacks,team, player, statistics,Users
from flaskblog.main.sentiment import word_tokenize,remove_noise
from flaskblog.notifications import notification,friendreq
# from flaskblog.main.utilsml import save_picture, load_image, run_example
from flask import Blueprint, flash, render_template, request, redirect, url_for,make_response,jsonify,flash
import pickle,csv #

from sqlalchemy import func
main = Blueprint("main", __name__)
admin.name="Dashboard"
admin.add_view(AdminView(Users,db.session))
admin.add_view(FeedbackView(feedbacks,db.session))
admin.add_view(NotifyView(name="notify", endpoint='notify'))
admin.add_view(AnalyticsView(name="analytics",endpoint='analytics'))

@main.route("/")
@main.route("/home")
def home():
    page = request.args.get("page", 1, type=int)
    posts = Posts.query.order_by(Posts.date_posted.desc()).paginate(
        page=page, per_page=5
    )
    print (friendreq())
    return render_template("home.html", posts=posts,notifications=notification(),req=friendreq())


@main.route("/ml")
def ml():
    return render_template("about.html",notifications=notification(),req=friendreq())
@main.route("/feedback")
def feedback():
    return render_template("feedback.html",notifications=notification(),req=friendreq())
@main.route("/feedback/create-entry",methods=["POST"])
def create_entry():
    
    req=request.get_json()

    
    with open("sentiment.pickle","rb") as f:
        classifier=pickle.load(f)
    custom_tokens = remove_noise(word_tokenize(req['message']))
    sentiment=classifier.classify(dict([token, True] for token in custom_tokens))
    f=feedbacks(fname=req['name'],message=req['message'],sentiment=sentiment)
    db.session.add(f)
    db.session.commit()
    flash('Feedback Received')
    #if we put rq instead of message it will be displayed below
    
    res=make_response(jsonify(req),200)
    return res

"""
@main.route("/ml", methods=["GET", "POST"])
def ml():

    if request.method == "GET":
        # show the upload form
        return render_template("ml.html",notifications=notification(),req=friendreq())
    if request.method == "POST":
        image_file = request.files["image"]
        if image_file.filename == "":
            flash("No file was uploaded.")
            return redirect(request.url)
        if image_file:
            pfn = save_picture(image_file)
            x = run_example(pfn)
            print(x)
            if x == 1:
                result = "cats"
            else:
                result = "dogs"
            return render_template("predict.html", result=result,notifications=notification(),req=friendreq())

"""


@main.route("/stats", methods=["GET", "POST"])
def stat():
    return redirect(url_for("stat.stats_year", year=2018,notifications=notification(),req=friendreq()))


@main.route("/about")
def about():
    return render_template(
        "about.html", title="About", posts=Posts,notifications=notification(),req=friendreq()
    )  # encountered error with Posts
