require_relative('../db/sql_runner')

class Game

  attr_reader :id, :name, :type_id

  def initialize(options)
    @id = nil || options['id'].to_i
    @name = options['name']
    @type_id = options['type_id'].to_i
  end

  def save()
    sql = "INSERT INTO games (name, type_id) VALUES ('#{@name}', #{@type_id}) RETURNING *"
    results = SqlRunner.run(sql).first
    @id = results['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM games"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM games"
    results = SqlRunner.run(sql)
    return results.map {|game| Game.new(game)}
  end

  def self.find(id)
    sql = "SELECT * FROM games WHERE id = #{id}"
    results = SqlRunner.run(sql).first
    return Game.new(results)
  end

end