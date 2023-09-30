from flask import render_template, url_for, flash, redirect, request, Blueprint
from flask_login import login_user, current_user, logout_user, login_required
from flaskblog import db, bcrypt, socketio,limiter
from flaskblog.notifications import notification,friendreq
from wtforms.validators import DataRequired, Length, Email, EqualTo, ValidationError
from flaskblog.models import Users, Posts, Friends, Messages,Groups,FriendRequest
from flaskblog.models import GroupMessages,GroupMembers
from flaskblog.usersroute.forms import (
    RegistrationForm,
    LoginForm,
    UpdateAccountForm,
    RequestResetForm,
    ResetPasswordForm,
    FriendForm,
    GroupForm
)
from flask import jsonify,make_response,request
from sqlalchemy import text,or_
from flaskblog.usersroute.utils import save_picture, send_reset_email
from flask_socketio import SocketIO, send, emit
import datetime
from datetime import timezone
import time
import json
from json import JSONEncoder
import jsonpickle
usersroute = Blueprint("usersroute", __name__)
@usersroute.route("/slow")
@limiter.limit("1 per day")
def slow():
    return ":("

@usersroute.route("/medium")
@limiter.limit("1/second", override_defaults=False)
def medium():
    return ":|"

@usersroute.route("/fast")
def fast():
    return ":)"


@usersroute.route("/ping")
@limiter.exempt
def ping():
    return "PONG"




@usersroute.route("/register", methods=["GET", "POST"])
def register():
    if current_user.is_authenticated:
        return redirect(url_for("main.home"))
    form = RegistrationForm()
    if form.validate_on_submit():
        hashed_password = bcrypt.generate_password_hash(form.password.data).decode(
            "utf-8"
        )
        # otherwise in  binary format
        user = Users(
            username=form.username.data, email=form.email.data, password=hashed_password
        )
        db.session.add(user)
        db.session.commit()
        flash("Your account has been created! You are now able to log in", "success")
        return redirect(url_for("usersroute.login"))
    return render_template("register.html", title="Register", form=form,notifications=notification(),req=friendreq())


@usersroute.route("/login", methods=["GET", "POST"])
def login():
    if current_user.is_authenticated:
        return redirect(url_for("main.home"))
    form = LoginForm()
    if form.validate_on_submit():
        user = Users.query.filter_by(email=form.email.data).first()
        if user and bcrypt.check_password_hash(user.password, form.password.data):
            login_user(user, remember=form.remember.data)  # flask_login provides
            next_page = request.args.get("next")  #
            return redirect(next_page) if next_page else redirect(url_for("main.home"))
        else:
            flash("Login Unsuccessful. Please check email and password", "danger")
    return render_template("login.html", title="Login", form=form,notifications=notification(),req=friendreq())


@usersroute.route("/logout")
def logout():
    logout_user()
    return redirect(url_for("main.home"))


@usersroute.route("/account", methods=["GET", "POST"])
@login_required
def account():
    form = UpdateAccountForm()
    if form.validate_on_submit():
        if form.picture.data:
            picture_file = save_picture(form.picture.data)
            current_user.image_file = picture_file
        current_user.username = form.username.data
        current_user.email = form.email.data
        db.session.commit()
        flash("Your account has been updated!", "success")
        return redirect(url_for("usersroute.account"))
    elif request.method == "GET":
        form.username.data = current_user.username
        form.email.data = current_user.email
    image_file = url_for("static", filename="profile_pics/" + current_user.image_file)
    return render_template(
        "account.html", title="Account", image_file=image_file, form=form,notifications=notification(),req=friendreq()
    )


@usersroute.route("/add-friend", methods=["GET", "POST"])
@login_required
def friends():
    form = FriendForm()
    if form.validate_on_submit():
        friend1 = Users.query.filter_by(username=form.friend_name.data).first()
        # freind = Friends.query.all()
        # for r in freind:
        #    print(r.user_id1)
        db.create_all()
        db.session.commit()
        f = FriendRequest(user_id1=current_user.id, user_id2=friend1.id)
        db.session.add(f)
        db.session.commit()
        flash("friend request sent", "success")
    return render_template("friend.html", form=form,notifications=notification(),req=friendreq())


@usersroute.route("/friends", methods=["GET", "POST"])
@login_required
def chat():
    user1 = Friends.query.filter_by(user_id1=current_user.id).all()
    user2 = Friends.query.filter_by(user_id2=current_user.id).all()
    l = []
    for r1 in user1:
        l.append(r1.user_id2)
    for r2 in user2:
        l.append(r2.user_id1)
    p = []
    for r in l:
        user = Users.query.filter_by(id=r).first()
        p.append(user)

    return render_template("chatmain.html", list=p,notifications=notification(),req=friendreq())
@usersroute.route("/group",methods=["GET","POST"])
def group():
    form=GroupForm()
    if form.validate_on_submit():
        member = Users.query.filter_by(username=form.friend_name.data).first()
        group=Groups.query.filter_by(id=form.group_id.data).first()
        member1=GroupMembers.query.filter_by(group_id=form.group_id.data).filter_by(member=member.id).all()
        #db.create_all()
        #g=GroupMembers()
        #gm=GroupMessages()
        #db.session.commit()
        if group is None:
            g=Groups(id=form.group_id.data,admin=current_user.id,name=form.group_id.data)
            db.session.add(g)
            db.session.commit()
        if member1:
                flash("Hes already in this group","warning")
        else: 
            gm=GroupMembers(group_id=form.group_id.data,member=member.id)
            db.session.add(gm)
            db.session.commit()           
            flash("Added Friend to group", "info")
            form.friend_name.data=""
        
    return render_template("group.html",form=form,notifications=notification(),req=friendreq())

@socketio.on("display-chat")
def on_message(data):
    friend_name = data["friend_name"]
    friend = Users.query.filter_by(username=friend_name).first()
    f1 = (
        Friends.query.filter_by(user_id1=current_user.id)
        .filter_by(user_id2=friend.id)
        .first()
    )

    if f1 is None:
        f1 = (
            Friends.query.filter_by(user_id2=current_user.id)
            .filter_by(user_id1=friend.id)
            .first()
        )

    m1 = (
        Messages.query.filter_by(friend_id=f1.id)
        .order_by(Messages.message_date.asc())
        .all()
    )
    l = []
    for r in m1:
        p = [r.content, r.message_date.strftime("%b-%d %I:%M%p"), r.start]
        l.append(p)
    read=Messages.query.filter_by(friend_id=f1.id).filter_by(start=friend.id).filter_by(read=0)
    for messages in read:
        messages.read=1
        db.session.commit()
    emit(
        "display-chat",
        {
            "friend_name": friend_name,
            "friend_id": friend.id,
            "messages": l,
            "friend_image": friend.image_file,
        },
    )


@socketio.on("message")
def handleMessage(data):
    message = data["msg"]
    friend_name = data["friend_name"]
    user = data["user"]
    print (message,friend_name,user)
    friend = Users.query.filter_by(username=friend_name).first()
    
    f1 = (
        Friends.query.filter_by(user_id1=current_user.id)
        .filter_by(user_id2=friend.id)
        .first()
    )

    if f1 is None:
        f1 = (
            Friends.query.filter_by(user_id2=current_user.id)
            .filter_by(user_id1=friend.id)
            .first()
        )

    message_time = datetime.datetime.now()
    m = Messages(
        content=message,
        friend_id=f1.id,
        start=current_user.id,
        message_date=message_time,
    )
            
    time_stamp = message_time.strftime("%b-%d %I:%M%p")
    db.session.add(m)
    db.session.commit()
    
    read=Messages.query.filter_by(friend_id=f1.id).filter_by(start=friend.id).filter_by(read=0)
    for messages in read:
        messages.read=1
        db.session.commit()
    send(
        {"msg": message, "fid": friend.id, "user": user, "time_stamp": time_stamp},
        broadcast=True,
    )


@usersroute.route("/chat", methods=["GET", "POST"])
@login_required
def message():
    sql = text(
        "select user_id1,user_id2,message_date,friend_id from Friends,Messages where Friends.id=Messages.friend_id \
        and (friend_id,message_date) in (select friend_id,max(message_date) from Messages group by friend_id order\
         by max(message_date)) and (user_id1=:a or user_id2=:a) order by message_date desc;"
    )
    friends = []
    results = db.engine.execute(sql, a=current_user.id)
    
    for r in results:
        if r["user_id1"] != current_user.id:
            friend_name = Users.query.filter_by(id=r["user_id1"]).first()
            friends.append(friend_name)
        if r["user_id2"] != current_user.id:
            friend_name = Users.query.filter_by(id=r["user_id2"]).first()
            friends.append(friend_name)
    #if person hasnt sent messages till now but still friend
    user1 = Friends.query.filter_by(user_id1=current_user.id).all()
    user2 = Friends.query.filter_by(user_id2=current_user.id).all()
    for r in user1:
        m=db.session.query(Messages).filter_by(friend_id=r.id).count()
        if m==0:
            p=Users.query.filter_by(id=r.user_id2).first()
            friends.append(p)
    for r in user2:
        m=db.session.query(Messages).filter_by(friend_id=r.id).count()
        
        if m==0:
            p=Users.query.filter_by(id=r.user_id1).first()
            friends.append(p)
    #a=Groups.query.filter_by(admin=current_user.id)
    #if a is not None:
    #    friends.append(a)
    
    return render_template("chat.html", friends=friends,notifications=notification(),req=friendreq())
@usersroute.route("/friendrequest")
def friendrequest():
    f=FriendRequest.query.filter_by(user_id2=current_user.id).order_by(FriendRequest.id).all()
    l=[]
    for user in f:
        friend=Users.query.filter_by(id=user.user_id1).first()
        l.append(friend)
    return render_template("followrequest.html",friends=l,notifications=notification(),req=friendreq())
@usersroute.route("/friendrequest/accept",methods=["POST"])
def friendrequestaccept():
    req=request.get_json()
    fr=FriendRequest.query.filter_by(user_id1=req['id']).filter_by(user_id2=current_user.id).first()
    db.session.delete(fr)
    db.session.commit()
    f=Friends(user_id1=req['id'],user_id2=current_user.id)
    db.session.add(f)
    db.session.commit()
    res=make_response(jsonify(req),200)#200response is succes
    return res
@usersroute.route("/friendrequest/reject",methods=["POST"])
def friendrequestreject():
    req=request.get_json()
    fr=FriendRequest.query.filter_by(user_id1=req['id']).filter_by(user_id2=current_user.id).first()
    db.session.delete(fr)
    db.session.commit()
    res=make_response(jsonify(req),200)
    return res
@usersroute.route("/user/<string:username>")
def user_posts(username):
    page = request.args.get("page", 1, type=int)
    user = Users.query.filter_by(username=username).first_or_404()
    posts = (
        Posts.query.filter_by(author=user)
        .order_by(Posts.date_posted.desc())
        .paginate(page=page, per_page=5)
    )
    return render_template("user_posts.html", posts=posts, user=user,notifications=notification(),req=friendreq())


@usersroute.route("/reset_password", methods=["GET", "POST"])
def reset_request():
    if current_user.is_authenticated:
        return redirect(url_for("main.home"))
    form = RequestResetForm()
    if form.validate_on_submit():
        user = Users.query.filter_by(email=form.email.data).first()
        send_reset_email(user)
        flash(
            "An email has been sent with instructions to reset your password.", "info"
        )
        return redirect(url_for("usersroute.login"))
    return render_template("reset_request.html", title="Reset Password", form=form,notifications=notification(),req=friendreq())


@usersroute.route("/reset_password/<token>", methods=["GET", "POST"])
def reset_token(token):
    if current_user.is_authenticated:
        return redirect(url_for("main.home"))
    user = Users.verify_reset_token(token)
    if user is None:
        flash("That is an invalid or expired token", "warning")
        return redirect(url_for("usersroute.reset_request"))
    form = ResetPasswordForm()
    if form.validate_on_submit():
        hashed_password = bcrypt.generate_password_hash(form.password.data).decode(
            "utf-8"
        )
        user.password = hashed_password
        db.session.commit()
        flash("Your password has been updated! You are now able to log in", "success")
        return redirect(url_for("usersroute.login"))
    return render_template("reset_token.html", title="Reset Password", form=form,notifications=notification(),req=friendreq())

