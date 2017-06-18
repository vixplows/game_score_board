require_relative('../db/sql_runner')

class Player

  attr_reader :id, :name
    
  def initialize(options)
    @id = nil || options['id'].to_i
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO players (name) VALUES ('#{@name}') RETURNING *"
    results = SqlRunner.run(sql).first
    @id = results['id'].to_i
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