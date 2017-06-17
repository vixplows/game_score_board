require_relative('../db/sql_runner')

class PlayerSession

  attr_reader :id, :player_id, :session_id, :result_id, :points

  def initialize(options)
    @id = nil || options['id'].to_i
    @player_id = options['player-id'].to_i
    @session_id = options['session-id'].to_i
    @result_id = options['result-id'].to_i
    @points = options['points'].to_i
  end

  def save()
    sql = "INSERT INTO players_sessions (player_id, session_id, result_id, points) VALUE (#{@player_id}, #{@session_id}, #{@result_id}, #{@points}) RETURNING *"
    results = SqlRunner.run(sql).first
    @id = results['id'].to_i
  end

end