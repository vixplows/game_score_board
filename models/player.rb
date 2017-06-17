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

  def self.delete_all
    sql = "DELETE FROM players"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM players"
    results = SqlRunner.run(sql)
    return results.map {|player| Player.new(player)}
  end

end