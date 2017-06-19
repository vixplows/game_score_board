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

#return name of all games player has played sessions of. Refactor so that game name only appears once
  def games()
    sql = "SELECT games.* FROM games, players, sessions, players_sessions WHERE players.id = #{id} AND players.id = players_sessions.player_id AND sessions.game_id = games.id AND players_sessions.session_id = sessions.id"
    results = SqlRunner.run(sql)
    return results.map {|game| Game.new(game)}
  end

#returns results_id for sessions played by player. Use to provide input for player performance page, like @session.results was used in session score card
  def results()
    sql = "SELECT players_sessions.result_id FROM players, players_sessions WHERE players.id = #{id} AND players_sessions.player_id = players.id"
    results = SqlRunner.run(sql)
    return results
  end

  # def all_wins_sorted
  #   sql = "SELECT players.name FROM results, players, players_sessions, sessions where results.id = players_sessions.result_id AND players.id = players_sessions.player_id AND players_sessions.session_id = sessions.id AND results.tag = 'Won'"
  #   results = SqlRunner.run(sql)
  #   for results in results do
  #     if result['name'] = 
  #   end
  # end

  # def self.sort_players_by_wins
  #   players = Players.all
  #   for player in players do
  #     sql = "SELECT * FROM players, players_sessions, results WHERE players.id = #{id} AND players_sessions.player_id = players.id AND players_sessions.result_id = results.id AND results.tag = 'Won'"
  #     wins = SqlRunner.run(sql)
  #     table_input = wins.count
  #   end
  # end

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
end