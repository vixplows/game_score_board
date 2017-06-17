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

  def self.delete_all
    sql = "DELETE FROM players_sessions"
    SqlRunner.run(sql)
  end

end