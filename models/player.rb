require_relative('../db/sql_runner')
require('pry-byebug')

class Player

  attr_reader :id, :name, :image
    
  def initialize(options)
    @id = nil || options['id'].to_i
    @name = options['name']
    @image = options['image']
  end

  def save()
    sql = "INSERT INTO players (name, image) VALUES ('#{@name}', '#{@image}') RETURNING *"
    results = SqlRunner.run(sql).first
    @id = results['id'].to_i
  end

  def play()
    sql = "SELECT * FROM players, players_sessions WHERE players.id = #{id} AND players_sessions.player_id = players.id"
    plays = SqlRunner.run(sql)
    return plays.count
  end

  def latest_session()
    sql = "SELECT games.name, sessions.date FROM players, players_sessions, sessions, games WHERE players.id = #{id} AND players.id = players_sessions.player_id AND sessions.id = players_sessions.session_id AND games.id = sessions.game_id ORDER BY date"
    results = SqlRunner.run(sql).first
    return results
  end

#return name of all games player has played sessions of. NEED TO Refactor so that game name only appears once
  def games()
    sql = "SELECT games.* FROM games, players, sessions, players_sessions WHERE players.id = #{id} AND players.id = players_sessions.player_id AND sessions.game_id = games.id AND players_sessions.session_id = sessions.id ORDER BY name"
    results = SqlRunner.run(sql)
    return results.map {|game| Game.new(game)}
  end

  def won()
    sql = "SELECT * FROM players, players_sessions, results WHERE players.id = #{id} AND players_sessions.player_id = players.id AND players_sessions.result_id = results.id AND results.tag = 'Won'"
    wins = SqlRunner.run(sql)
    return wins.count
  end

  def lost()
    sql = "SELECT * FROM players, players_sessions, results WHERE players.id = #{id} AND players_sessions.player_id = players.id AND players_sessions.result_id = results.id AND results.tag = 'Lost'"
    losses = SqlRunner.run(sql)
    return losses.count
  end

  def drew()
    sql = "SELECT * FROM players, players_sessions, results WHERE players.id = #{id} AND players_sessions.player_id = players.id AND players_sessions.result_id = results.id AND results.tag = 'Drew'"
    draws = SqlRunner.run(sql)
    return draws.count
  end

  def points_total
    sql = "SELECT players_sessions.points FROM players, players_sessions WHERE players.id = #{id} AND players.id = players_sessions.player_id"
    results = SqlRunner.run(sql)
    sum = 0
    results.each {|session_points| sum += session_points['points'].to_i}
    return sum
  end

# trying to get all results for all players ordered by greatest number of wins...
  def self.sort_results
    sql = ""
  end

  def self.delete_all
    sql = "DELETE FROM players"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM players"
    results = SqlRunner.run(sql)
    return results.map {|player| Player.new(player)}
  end

  def self.find(id)
    sql = "SELECT * FROM players WHERE id = #{id}"
    results = SqlRunner.run(sql).first
    return Player.new(results)
  end
end