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

  def update()
    sql = "UPDATE players SET (name, image) = ('#{@name}', '#{@image}') WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM players WHERE players.id = #{id}"
    SqlRunner.run(sql)
  end

  def play()
    sql = "SELECT * FROM players, players_sessions WHERE players.id = #{id} AND players_sessions.player_id = players.id"
    plays = SqlRunner.run(sql)
    return plays.count.to_i
  end

  def latest_session()
    sql = "SELECT games.name, sessions.date FROM players, players_sessions, sessions, games WHERE players.id = #{id} AND players.id = players_sessions.player_id AND sessions.id = players_sessions.session_id AND games.id = sessions.game_id ORDER BY date DESC"
    results = SqlRunner.run(sql).first
    return results
  end

  def sessions
    sql = "SELECT games.name, sessions.date, results.tag, sessions.id FROM players, games, results, players_sessions, sessions WHERE players.id = #{id} AND players.id = players_sessions.player_id AND players_sessions.session_id = sessions.id AND players_sessions.result_id = results.id AND games.id = sessions.game_id ORDER BY date DESC"
    results = SqlRunner.run(sql)
    return results.map
  end

  def games()
    sql = "SELECT DISTINCT games.* FROM games, players, sessions, players_sessions WHERE players.id = #{id} AND players.id = players_sessions.player_id AND sessions.game_id = games.id AND players_sessions.session_id = sessions.id ORDER BY name"
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

  def self.wins
  sql = "SELECT players.name, count(*) as wins FROM players, players_sessions, results WHERE players_sessions.player_id = players.id AND players_sessions.result_id = results.id AND results.tag = 'Won' group by players.name ORDER BY wins DESC"
  winners = SqlRunner.run(sql)
  return winners
  end

  def self.losses
    sql = "SELECT players.name, count(*) as losses FROM players, players_sessions, results WHERE players_sessions.player_id = players.id AND players_sessions.result_id = results.id AND results.tag = 'Lost' group by players.name ORDER BY losses DESC"
    losers = SqlRunner.run(sql)
    return losers
  end
end