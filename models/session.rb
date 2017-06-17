require_relative('../db/sql_runner')

class Session

  attr_reader :id, :game_id, :date, :start_time, :end_time

  def initialize(options)
    @id = nil || options['id'].to_i
    @game_id = options['game-id'].to_i
    @date = options['date']
    @start_time = options['start_time']
    @end_time = options['end_time']
  end

  def save()
    sql = "INSERT INTO sessions (game_id, date, start_time, end_tie) VALUE (#{@game_id}, '#{date}', '#{@start_time}', '#{@end_time}') RETURNING *"
    results = SqlRunner.run(sql).first
    @id = results['id'].to_i
  end

end