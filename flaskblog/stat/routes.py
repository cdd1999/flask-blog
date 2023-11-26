from flask import render_template, request, Blueprint, redirect, url_for
from sqlalchemy import text, func
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

def getStatResults(stat, year, leagueName, page):
  if (stat == 'goals'):
    statsColumn = statistics.goals
  elif (stat == 'assists'):
    statsColumn = statistics.assists
  elif (stat == 'saves'):
    statsColumn = statistics.saves
  elif (stat == 'red_cards'):
    statsColumn = statistics.red_cards

  if leagueName == 'all' and year == 1:
    results = (
      db.session.query(player.fname, player.lname, func.sum(statsColumn).label(stat), func.sum(statistics.appearances).label('appearances'), player.team_name, player.position)
      .group_by(player.fname, player.lname, player.team_name, player.position)
      .order_by(func.sum(statsColumn).desc())
      .join(player, player.id == statistics.player_id)
      .join(nationality, nationality.name == player.nation)
      .join(position, position.id == player.position)
      .join(team, team.name == player.team_name)
      .paginate(per_page = 10, page = page)
    )
  elif year == 1:
    results = (
      db.session.query(player.fname, player.lname, func.sum(statsColumn).label(stat), func.sum(statistics.appearances).label('appearances'), player.team_name, player.position)
      .group_by(player.fname, player.lname,player.team_name, player.position)
      .order_by(func.sum(statsColumn).desc())
      .join(player, player.id == statistics.player_id)
      .join(nationality, nationality.name == player.nation)
      .join(position, position.id == player.position)
      .join(team, team.name == player.team_name)
      .join(league, team.league_name == league.name)
      .filter(league.name == leagueName)
      .paginate(per_page = 10, page = page)
    )
  elif leagueName == 'all':
    results = (
      db.session.query(player.fname, player.lname, statistics.year, func.sum(statsColumn).label(stat), func.sum(statistics.appearances).label('appearances'), player.team_name, player.position)
      .group_by(player.fname, player.lname, player.team_name, player.position, statistics.year)
      .order_by(func.sum(statsColumn).desc())
      .join(player, player.id == statistics.player_id)
      .join(nationality, nationality.name == player.nation)
      .join(position, position.id == player.position)
      .join(team, team.name == player.team_name)
      .filter(statistics.year == year)
      .paginate(per_page = 10, page = page)
    )
  else:
    results = (
      db.session.query(player.fname, player.lname, statistics.year, func.sum(statsColumn).label(stat), func.sum(statistics.appearances).label('appearances'), player.team_name, player.position)
      .group_by(player.fname, player.lname, player.team_name, player.position, statistics.year)
      .order_by(func.sum(statsColumn).desc())
      .join(player, player.id == statistics.player_id)
      .join(nationality, nationality.name == player.nation)
      .join(position, position.id == player.position)
      .join(team, team.name == player.team_name)
      .join(league, team.league_name == league.name)
      .filter(statistics.year == year)
      .filter(league.name == leagueName)
      .paginate(per_page = 10, page = page)
    )
  return results

@stat.route("/stats/<int:year>/<string:leagues>", methods=["GET", "POST"])
def stats_year(year,leagues):
  return render_template("stats/stats_intro.html", year=year,leagues=leagues,notifications=notification(),req=friendreq())


@stat.route("/stats/<int:year>/goals/<string:leagues>", methods=["GET", "POST"], defaults={ "page": 1 })
@stat.route("/stats/<int:year>/goals/<string:leagues>/<int:page>", methods=["GET", "POST"])
def goals(page, year, leagues):
  result = getStatResults(stat = 'goals', year = year, leagueName = leagues, page = page)
  return render_template("stats/goals.html", result = result, year = year, leagues = leagues, notifications = notification(), req = friendreq())


@stat.route("/stats/<int:year>/assists/<string:leagues>", methods=["GET", "POST"], defaults={ "page": 1 })
@stat.route("/stats/<int:year>/assists/<string:leagues>/<int:page>", methods=["GET", "POST"])
def assists(page, year,leagues):
  result = getStatResults(stat = 'assists', year = year, leagueName = leagues, page = page)
  return render_template("stats/assists.html", result = result, year = year, leagues = leagues, notifications = notification(), req = friendreq())


@stat.route("/stats/<int:year>/saves/<string:leagues>", methods=["GET", "POST"], defaults={ "page": 1 })
@stat.route("/stats/<int:year>/saves/<string:leagues>/<int:page>", methods=["GET", "POST"])
def saves(page, year,leagues):
  result = getStatResults(stat = 'saves', year = year, leagueName = leagues, page = page)
  return render_template("stats/saves.html", result = result, year = year, leagues = leagues, notifications = notification(), req = friendreq())


@stat.route("/stats/<int:year>/red_cards/<string:leagues>", methods=["GET", "POST"], defaults={ "page": 1 })
@stat.route("/stats/<int:year>/red_cards/<string:leagues>/<int:page>", methods=["GET", "POST"])
def red_cards(page, year,leagues):
  result = getStatResults(stat = 'red_cards', year = year, leagueName = leagues, page = page)
  return render_template("stats/red_cards.html", result = result, year = year, leagues = leagues, notifications = notification(), req = friendreq())

