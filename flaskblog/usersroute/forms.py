from flask_wtf import FlaskForm
from flask_wtf.file import FileField, FileAllowed
from wtforms import StringField, PasswordField, SubmitField, BooleanField,IntegerField
from wtforms.validators import DataRequired, Length, Email, EqualTo, ValidationError
from flask_login import current_user
from flaskblog.models import Users, Friends, Messages,GroupMessages,Groups


class RegistrationForm(FlaskForm):
    username = StringField(
        "Username", validators=[DataRequired(),Length(min=2, max=20)]
    )
    email = StringField("Email", validators=[DataRequired(), Email()])
    password = PasswordField("Password", validators=[DataRequired()])
    confirm_password = PasswordField(
        "Confirm Password", validators=[DataRequired(), EqualTo("password")]
    )
    submit = SubmitField("Sign Up")

    def validate_username(self, username):
        user = Users.query.filter_by(username=username.data).first()
        if user:
            raise ValidationError(
                "That username is taken. Please choose a different one."
            )

    def validate_email(self, email):
        email = Users.query.filter_by(email=email.data).first()
        if email:
            raise ValidationError("That email is taken. Please choose a different one.")


class LoginForm(FlaskForm):
    email = StringField("Email", validators=[DataRequired(), Email()])
    password = PasswordField("Password", validators=[DataRequired()])
    remember = BooleanField("Remember Me")
    submit = SubmitField("Login")
class GroupForm(FlaskForm):
    group_id=IntegerField("Enter a groupid ",validators=[DataRequired()])
    #group_name = StringField(
    #    "Group Name", validators=[DataRequired(), Length(min=1, max=20)]
    #)
    friend_name = StringField(
        "Friend you wanna add?", validators=[DataRequired(), Length(min=2, max=20)]
    )
    submit = SubmitField("Send")
    def validate_group_id(self,group_id):
        group=Groups.query.filter_by(id=group_id.data).first()
        if group is not None:
            if group.admin==current_user.id:
                pass
            else:
                raise ValidationError("This group id is taken Enter a new one!!!")


    def validate_friend_name(self,friend_name):
        
        user = Users.query.filter_by(username=friend_name.data).first()

        if user is None:
            raise ValidationError("There is no username with that name")

        if friend_name.data == current_user.username:
            raise ValidationError("Thats your username")

class FriendForm(FlaskForm):
    friend_name = StringField(
        "Friend you wanna add?", validators=[DataRequired(), Length(min=2, max=20)]
    )
    submit = SubmitField("Send")

    def validate_friend_name(self, friend_name):
        user = Users.query.filter_by(username=friend_name.data).first()

        if user is None:
            raise ValidationError("There is no username with that name")

        if friend_name.data == current_user.username:
            raise ValidationError("Thats your username")
        user1 = Friends.query.filter_by(user_id1=current_user.id).all()
        user2 = Friends.query.filter_by(user_id2=current_user.id).all()
        l = []
        for r1 in user1:
            l.append(r1.user_id2)
        for r2 in user2:
            l.append(r2.user_id1)

        for r in l:
            if r == user.id:
                raise ValidationError("Your already friends with him")


class UpdateAccountForm(FlaskForm):
    username = StringField(
        "Username", validators=[DataRequired(), Length(min=2, max=20)]
    )
    email = StringField("Email", validators=[DataRequired(), Email()])
    picture = FileField(
        "Update Profile Picture", validators=[FileAllowed(["jpg", "png"])]
    )
    submit = SubmitField("Update")

    def validate_username(self, username):
        if username.data != current_user.username:
            user = Users.query.filter_by(username=username.data).first()
            if user:
                raise ValidationError(
                    "That username is taken. Please choose a different one."
                )

    def validate_email(self, email):
        if email.data != current_user.email:
            email = Users.query.filter_by(email=email.data).first()
            if email:
                raise ValidationError(
                    "That email is taken. Please choose a different one."
                )


class RequestResetForm(FlaskForm):
    email = StringField("Email", validators=[DataRequired(), Email()])
    submit = SubmitField("Request Password Reset")

    def validate_email(self, email):
        user = Users.query.filter_by(email=email.data).first()
        if user is None:
            raise ValidationError(
                "There is no account with that email. You must register first."
            )


class ResetPasswordForm(FlaskForm):
    password = PasswordField("Password", validators=[DataRequired()])
    confirm_password = PasswordField(
        "Confirm Password", validators=[DataRequired(), EqualTo("password")]
    )
    submit = SubmitField("Reset Password")

