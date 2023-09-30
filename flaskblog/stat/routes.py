from flask import render_template, request, Blueprint, redirect, url_for
from sqlalchemy import text
from flaskblog.models import (
    Posts,
    team,
    player,
    statistics,
    league,
    nationality,
    coach,
    position,
)
from flaskblog import db
from flaskblog.notifications import notification,friendreq
stat = Blueprint("stat", __name__)


"""
    LIKE: query.filter(User.name.like('%ednalan%'))
    equals: query.filter(User.name == 'ednalan')
    IN: query.filter(User.name.in_(['rai', 'kenshin', 'Ednalan']))
    AND: query.filter(User.name == 'ednalan', User.fullname == 'clyde ednalan')
    OR: from sqlalchemy import or_ 
    filter(or_(User.name == 'ednalan', User.name == 'caite'))
    for limit(2)
    offset(2)
    group_by functions
    """


# sql = text('select * from team,nationality,player,statistics,league,coach,position where coach.nation=nationality.name and team.league_name=league.name and team.coach_id=coach.id and player.team_name=team.name and player.nation=nationality.name and player.position=position.id and statistics.player_id=player.id')
# results = db.engine.execute(sql).paginate()
# for r in results:
#    print (r['league_name'])
@stat.route("/stats/<int:year>/<string:leagues>", methods=["GET", "POST"])
def stats_year(year,leagues):

    return render_template("stats/stats_intro.html", year=year,leagues=leagues,notifications=notification(),req=friendreq())


@stat.route("/stats/<int:year>/goals/<string:leagues>", methods=["GET", "POST"], defaults={"page": 1})
@stat.route("/stats/<int:year>/goals/<string:leagues>/<int:page>", methods=["GET", "POST"])
def goals(page, year,leagues):
    if leagues=='all' and year==1:
        s = (
        db.session.query(statistics)
        .order_by(statistics.goals.desc())
        .join(player, player.id == statistics.player_id)
        .join(nationality, nationality.name == player.nation)
        .join(position, position.id == player.position)
        .join(team, team.name == player.team_name)
        .paginate(per_page=10, page=page)
        )
    elif leagues=='all':
        s = (
        db.session.query(statistics)
        .filter_by(year=year)
        .order_by(statistics.goals.desc())
        .join(player, player.id == statistics.player_id)
        .join(nationality, nationality.name == player.nation)
        .join(position, position.id == player.position)
        .join(team, team.name == player.team_name)
        .paginate(per_page=10, page=page)
        )
    elif year==1:
         s = (
            db.session.query(statistics)
            .order_by(statistics.goals.desc())
            .join(player, player.id == statistics.player_id)
            .join(nationality, nationality.name == player.nation)
            .join(position, position.id == player.position)
            .join(team, team.name == player.team_name)
            .join(league, team.league_name == league.name).filter(league.name==leagues)
            .paginate(per_page=10, page=page)
         )
    else:
        s = (
            db.session.query(statistics)
            .filter_by(year=year)
            .order_by(statistics.goals.desc())
            .join(player, player.id == statistics.player_id)
            .join(nationality, nationality.name == player.nation)
            .join(position, position.id == player.position)
            .join(team, team.name == player.team_name)

            .join(league, team.league_name == league.name).filter(league.name==leagues)
            .paginate(per_page=10, page=page)
        )
  
    return render_template("stats/goals.html", result=s, year=year,leagues=leagues,notifications=notification(),req=friendreq())


@stat.route("/stats/<int:year>/assists/<string:leagues>", methods=["GET", "POST"], defaults={"page": 1})
@stat.route("/stats/<int:year>/assists/<string:leagues>/<int:page>", methods=["GET", "POST"])
def assists(page, year,leagues):
    if leagues=='all' and year==1:
        s = (
        db.session.query(statistics)
        .order_by(statistics.assists.desc())
        .join(player, player.id == statistics.player_id)
        .join(nationality, nationality.name == player.nation)
        .join(position, position.id == player.position)
        .join(team, team.name == player.team_name)
        .paginate(per_page=10, page=page)
        )
    elif leagues=='all':
        s = (
        db.session.query(statistics)
        .filter_by(year=year)
        .order_by(statistics.assists.desc())
        .join(player, player.id == statistics.player_id)
        .join(nationality, nationality.name == player.nation)
        .join(position, position.id == player.position)
        .join(team, team.name == player.team_name)
        .paginate(per_page=10, page=page)
    )
    elif year==1:
         s = (
            db.session.query(statistics)
            .order_by(statistics.assists.desc())
            .join(player, player.id == statistics.player_id)
            .join(nationality, nationality.name == player.nation)
            .join(position, position.id == player.position)
            .join(team, team.name == player.team_name)
            .join(league, team.league_name == league.name).filter(league.name==leagues)
            .paginate(per_page=10, page=page)
        )
    else:
        s = (
            db.session.query(statistics)
            .filter_by(year=year)
            .order_by(statistics.assists.desc())
            .join(player, player.id == statistics.player_id)
            .join(nationality, nationality.name == player.nation)
            .join(position, position.id == player.position)
            .join(team, team.name == player.team_name)

            .join(league, team.league_name == league.name).filter(league.name==leagues)
            .paginate(per_page=10, page=page)
        )
  
    return render_template("stats/assists.html", result=s, year=year,leagues=leagues,notifications=notification(),req=friendreq())


@stat.route("/stats/<int:year>/saves/<string:leagues>", methods=["GET", "POST"], defaults={"page": 1})
@stat.route("/stats/<int:year>/saves/<string:leagues>/<int:page>", methods=["GET", "POST"])
def saves(page, year,leagues):
    if leagues=='all' and year==1:
        s = (
        db.session.query(statistics)
        .order_by(statistics.saves.desc())
        .join(player, player.id == statistics.player_id)
        .join(nationality, nationality.name == player.nation)
        .join(position, position.id == player.position)
        .join(team, team.name == player.team_name)
        .paginate(per_page=10, page=page)
        )
    elif leagues=='all':
        s = (
        db.session.query(statistics)
        .filter_by(year=year)
        .order_by(statistics.saves.desc())
        .join(player, player.id == statistics.player_id)
        .join(nationality, nationality.name == player.nation)
        .join(position, position.id == player.position)
        .join(team, team.name == player.team_name)
        .paginate(per_page=10, page=page)
        )
    elif year==1:
         s = (
            db.session.query(statistics)
            .order_by(statistics.saves.desc())
            .join(player, player.id == statistics.player_id)
            .join(nationality, nationality.name == player.nation)
            .join(position, position.id == player.position)
            .join(team, team.name == player.team_name)
            .join(league, team.league_name == league.name).filter(league.name==leagues)
            .paginate(per_page=10, page=page)
        )
    else:
        s = (
            db.session.query(statistics)
            .filter_by(year=year)
            .order_by(statistics.saves.desc())
            .join(player, player.id == statistics.player_id)
            .join(nationality, nationality.name == player.nation)
            .join(position, position.id == player.position)
            .join(team, team.name == player.team_name)

            .join(league, team.league_name == league.name).filter(league.name==leagues)
            .paginate(per_page=10, page=page)
        )
  
    return render_template("stats/saves.html", result=s, year=year,leagues=leagues,notifications=notification(),req=friendreq())


@stat.route(
    "/stats/<int:year>/red_cards/<string:leagues>", methods=["GET", "POST"], defaults={"page": 1}
)
@stat.route("/stats/<int:year>/red_cards/<string:leagues>/<int:page>", methods=["GET", "POST"])
def red_cards(page, year,leagues):
    if leagues=='all' and year==1:
        s = (
        db.session.query(statistics)
        .order_by(statistics.red_cards.desc())
        .join(player, player.id == statistics.player_id)
        .join(nationality, nationality.name == player.nation)
        .join(position, position.id == player.position)
        .join(team, team.name == player.team_name)
        .paginate(per_page=10, page=page)
        )
    elif leagues=='all':
        s = (
        db.session.query(statistics)
        .filter_by(year=year)
        .order_by(statistics.red_cards.desc())
        .join(player, player.id == statistics.player_id)
        .join(nationality, nationality.name == player.nation)
        .join(position, position.id == player.position)
        .join(team, team.name == player.team_name)
        .paginate(per_page=10, page=page)
    )
    elif year==1:
         s = (
            db.session.query(statistics)
            .order_by(statistics.red_cards.desc())
            .join(player, player.id == statistics.player_id)
            .join(nationality, nationality.name == player.nation)
            .join(position, position.id == player.position)
            .join(team, team.name == player.team_name)
            .join(league, team.league_name == league.name).filter(league.name==leagues)
            .paginate(per_page=10, page=page)
        )
    else:
        s = (
            db.session.query(statistics)
            .filter_by(year=year)
            .order_by(statistics.red_cards.desc())
            .join(player, player.id == statistics.player_id)
            .join(nationality, nationality.name == player.nation)
            .join(position, position.id == player.position)
            .join(team, team.name == player.team_name)

            .join(league, team.league_name == league.name).filter(league.name==leagues)
            .paginate(per_page=10, page=page)
        )
  
    return render_template("stats/red_cards.html", result=s, year=year,leagues=leagues,notifications=notification(),req=friendreq())

