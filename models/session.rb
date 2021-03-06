require_relative('../db/sql_runner')
require('time')

class Session

  attr_reader :id, :game_id, :date, :start_time, :end_time

  def initialize(options)
    @id = nil || options['id'].to_i
    @game_id = options['game_id'].to_i
    @date = options['date']
    @start_time = options['start_time']
    @end_time = options['end_time']
  end

  def save()
    sql = "INSERT INTO sessions (game_id, date, start_time, end_time) VALUES (#{@game_id}, '#{@date}', '#{@start_time}', '#{@end_time}') RETURNING *"
    results = SqlRunner.run(sql).first
    @id = results['id'].to_i
  end

  def update()
    sql = "UPDATE sessions SET (game_id, date, start_time, end_time) = (#{@game_id}, '#{@date}', '#{@start_time}', '#{@end_time}') WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def game()
    game = Game.find(@game_id)
    return game.name
  end

  def duration()
    session = Session.find(@id)
    end_time = Time.parse(session.end_time)
    start_time = Time.parse(session.start_time)
    difference = (end_time - start_time)/60
    return difference.to_i
  end

  def players()
    sql = "SELECT players.* FROM players_sessions
      INNER JOIN players ON players_sessions.player_id = players.id
      INNER JOIN sessions ON players_sessions.session_id = sessions.id
      WHERE sessions.id = #{id}"
    results = SqlRunner.run(sql)
    return results.map {|player| Player.new(player)}
  end

  def results()
    sql = "SELECT results.tag, players.name, players_sessions.points, players_sessions.id
      FROM players_sessions
      INNER JOIN sessions ON players_sessions.session_id = sessions.id
      INNER JOIN players ON players_sessions.player_id = players.id
      INNER JOIN results ON players_sessions.result_id = results.id
      WHERE sessions.id = #{id}"
    results = SqlRunner.run(sql)
    return results
  end

  def delete()
    sql = "DELETE FROM sessions WHERE id = #{id}"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM sessions"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM sessions"
    results = SqlRunner.run(sql)
    return results.map {|session| Session.new(session)}
  end

  def self.find(id)
    sql = "SELECT * FROM sessions WHERE id = #{id}"
    results = SqlRunner.run(sql).first
    return Session.new(results)
  end

end