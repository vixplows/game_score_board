require_relative('../db/sql_runner')

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
    sql = "INSERT INTO sessions (game_id, date, start_time, end_time) VALUES (#{@game_id}, '#{date}', '#{@start_time}', '#{@end_time}') RETURNING *"
    results = SqlRunner.run(sql).first
    @id = results['id'].to_i
  end

  def self.delete_all
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