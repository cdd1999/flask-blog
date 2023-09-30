from flaskblog.models import Messages,Friends,FriendRequest
from flaskblog import db
from sqlalchemy import or_,not_
from flask_login import current_user
def notification():
    if current_user.is_authenticated:
        friends=db.session.query(Friends).filter(or_(Friends.user_id1==current_user.id,Friends.user_id2==current_user.id))
        count=0
        for friend in friends:
            notifications=db.session.query(Messages).filter_by(friend_id=friend.id).filter(not_(Messages.start==current_user.id)).filter_by(read=0).count()
    
            count+=notifications
        return count
    return 0
def friendreq():
    if current_user.is_authenticated:
        count=0
        count=db.session.query(FriendRequest).filter_by(user_id2=current_user.id).count()
        return count
    return 0



