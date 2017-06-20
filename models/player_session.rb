require_relative('../db/sql_runner')

class PlayerSession

  attr_reader :id, :player_id, :session_id, :result_id, :points

  def initialize(options)
    @id = nil || options['id'].to_i
    @player_id = options['player_id'].to_i
    @session_id = options['session_id'].to_i
    @result_id = options['result_id'].to_i
    @points = options['points'].to_i
  end

  def save()
    sql = "INSERT INTO players_sessions (player_id, session_id, result_id, points) VALUES (#{@player_id}, #{@session_id}, #{@result_id}, #{@points}) RETURNING *"
    results = SqlRunner.run(sql).first
    @id = results['id'].to_i
  end

  def update()
    sql = "UPDATE players_sessions SET (player_id, session_id, result_id, points) = (#{@player_id}, #{@session_id}, #{@result_id}, #{@points}) WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def player()
    sql = "SELECT players_sessions.player_id FROM players_sessions, players WHERE players_sessions.id = #{id} AND players.id = players_sessions.player_id"
    results = SqlRunner.run(sql).first
    return results['player_id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM players_sessions"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM players_sessions"
    results = SqlRunner.run(sql)
    return results.map {|player_session| PlayerSession.new(player_session)}
  end

  def self.find(id)
    sql = "SELECT * FROM players_sessions WHERE id = #{id}"
    results = SqlRunner.run(sql).first
    return PlayerSession.new(results)
  end

end