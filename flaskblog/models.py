from datetime import datetime
from itsdangerous import URLSafeTimedSerializer as Serializer
from flask import current_app
from flaskblog import db, login_manager
from flask_login import UserMixin


@login_manager.user_loader  # reload user from session
def load_user(user_id):
    return Users.query.get(int(user_id))


class Users(db.Model, UserMixin):  # default implementations for the methods for flask -login
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(20), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    image_file = db.Column(db.String(20), nullable=False, default="default.jpg")
    password = db.Column(db.String(60), nullable=False)
    posts = db.relationship(
        "Posts", backref="author", lazy=True
    )  # if false then tables are joined
    #groupmemberstable = db.relationship("GroupMembersTable", backref="authorgum", lazy=True)
    def get_reset_token(self, expires_sec=1800):
        s = Serializer(current_app.config["SECRET_KEY"], expires_sec)
        return s.dumps({"user_id": self.id}).decode("utf-8")

    @staticmethod
    def verify_reset_token(token):
        s = Serializer(current_app.config["SECRET_KEY"])
        try:
            user_id = s.loads(token)["user_id"]  # its dictionary
        except:
            return None
        return Users.query.get(user_id)

    def __repr__(self):  # printing object info
        return f"Users('{self.username}', '{self.email}', '{self.image_file}')"
class FriendRequest(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id1 = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)
    user_id2 = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)

    friend_id1 = db.relationship(
        "Users", foreign_keys=[user_id1], backref="authorf12", lazy=True
    )
    friend_id2 = db.relationship(
        "Users", foreign_keys=[user_id2], backref="authorf22", lazy=True
    )

class Friends(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    friend_date = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    user_id1 = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)
    user_id2 = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)

    friend_id1 = db.relationship(
        "Users", foreign_keys=[user_id1], backref="authorf1", lazy=True
    )
    friend_id2 = db.relationship(
        "Users", foreign_keys=[user_id2], backref="authorf2", lazy=True
    )
    message = db.relationship("Messages", backref="authorf", lazy=True)

    def __repr__(self):
        return f"Friends('{self.id}')"
class Groups(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    
    group_date = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    admin = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)
    #groupmemberstable = db.relationship("GroupMembersTable", backref="authorgmem", lazy=True)
    name=db.Column(db.String(20), nullable=False)
    friend_id2 = db.relationship(
        "Users", foreign_keys=[admin], backref="authorgg1", lazy=True
    )
    def __repr__(self):
        return f"Groups('{self.id}')"

class GroupMessages(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    message_date = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    content = db.Column(db.Text, nullable=False)
    start = db.Column(db.Integer, nullable=False) 
    group_id = db.Column(db.Integer, db.ForeignKey("groups.id"), nullable=False)
    friend_id2 = db.relationship(
        "Groups", foreign_keys=[group_id], backref="authorgm2", lazy=True
    )
    def __repr__(self):
        return f"GroupMessages('{self.id}')"
class GroupMembers(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    member = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)
    group_id = db.Column(db.Integer, db.ForeignKey("groups.id"), nullable=False)
    group_id1 = db.relationship(
        "Groups", foreign_keys=[group_id], backref="authorgm3", lazy=True
    )
    member_id1 = db.relationship(
        "Users", foreign_keys=[member], backref="authorgm4", lazy=True
    )
    def __repr__(self):
        return f"GroupMembers('{self.id}','{self.member}','{self.group_id}')"
class Messages(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    message_date = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    content = db.Column(db.Text, nullable=False)
    friend_id = db.Column(db.Integer, db.ForeignKey("friends.id"), nullable=False)
    start = db.Column(db.Text, nullable=False)  # whther user 1 has started or user 2
    read=db.Column(db.Integer,nullable=False,default=0)
    def __repr__(self):
        return f"Messages('{self.id}', '{self.message_date}')"


class Posts(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    date_posted = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    content = db.Column(db.Text, nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)
    def __repr__(self):
        return f"Posts('{self.title}', '{self.date_posted}')"


class league(db.Model):
    name = db.Column(db.String(25), primary_key=True)
    country = db.Column(db.String(25), unique=True, nullable=False)
    team = db.relationship("team", backref="a", lazy=True)

    def __repr__(self):
        return f"league('{self.name}','{self.country}')"


class nationality(db.Model):
    name = db.Column(db.String(25), primary_key=True)
    continent = db.Column(db.String(25), unique=True, nullable=False)
    coach = db.relationship("coach", backref="b", lazy=True)
    player = db.relationship("player", backref="c", lazy=True)

    def __repr__(self):
        return f"nationality('{self.name}','{self.continent}')"


class position(db.Model):
    id = db.Column(db.String(2), primary_key=True)
    name = db.Column(db.String(25), unique=True, nullable=False)
    player = db.relationship("player", backref="d", lazy=True)

    def __repr__(self):
        return f"position('{self.id}','{self.name}')"


class coach(db.Model):
    id = db.Column(db.String(3), primary_key=True)
    name = db.Column(db.String(25), nullable=False)
    nation = db.Column(db.String(25), db.ForeignKey("nationality.name"), nullable=False)
    team = db.relationship("team", backref="e", lazy=True)

    def __repr__(self):
        return f"coach('{self.name}')"


class team(db.Model):
    name = db.Column(db.String(25), primary_key=True)
    league_position = db.Column(db.Integer, nullable=False)
    stadium = db.Column(db.String(25), nullable=False)
    city = db.Column(db.String(25), nullable=False)
    founded = db.Column(db.Integer, nullable=False)
    league_name = db.Column(db.String(25), db.ForeignKey("league.name"), nullable=False)
    coach_id = db.Column(db.String(3), db.ForeignKey("coach.id"), nullable=False)
    player = db.relationship("player", backref="f", lazy=True)

    def __repr__(self):
        return f"team('{self.name}','{self.league_position}','{self.stadium}','{self.city}','{self.founded}')"

class feedbacks(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    fname = db.Column(db.String(15), nullable=False)
    message = db.Column(db.Text, nullable=False)
    date_feedback = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    sentiment = db.Column(db.String(10), nullable=False)
    def __repr__(self):
        return f"feedback('{self.fname}'','{self.message}')"
class player(db.Model):
    id = db.Column(db.String(3), primary_key=True)
    fname = db.Column(db.String(15), nullable=False)
    lname = db.Column(db.String(15), nullable=False)
    team_name = db.Column(db.String(25), db.ForeignKey("team.name"), nullable=False)
    nation = db.Column(db.String(25), db.ForeignKey("nationality.name"), nullable=False)
    position = db.Column(db.String(2), db.ForeignKey("position.id"), nullable=False)
    statistics = db.relationship("statistics", backref="g", lazy=True)

    def __repr__(self):
        return f"player('{self.fname}'','{self.lname}')"


class statistics(db.Model):
    year = db.Column(db.Integer, primary_key=True)
    goals = db.Column(db.Integer, nullable=False)
    assists = db.Column(db.Integer, nullable=False)
    clean_sheets = db.Column(db.Integer, nullable=False)
    appearances = db.Column(db.Integer, nullable=False)
    yellow_cards = db.Column(db.Integer, nullable=False)
    red_cards = db.Column(db.Integer, nullable=False)
    saves = db.Column(db.Integer, nullable=False)
    player_id = db.Column(db.String(3), db.ForeignKey("player.id"), primary_key=True)

    def __repr__(self):
        return f"statistics('{self.year}','{self.goals}','{self.assists}','{self.clean_sheets}','{self.appearances}','{self.yellow_cards}','{self.red_cards}')"

