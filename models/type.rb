require_relative('../db/sql_runner')

class Type

  attr_reader :id, :name

  def initialize(options)
    @id = nil || options['id'].to_i
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO types (name) VALUES ('#{@name}') RETURNING *"
    results = SqlRunner.run(sql).first
    @id = results['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM types"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM types"
    results = SqlRunner.run(sql)
    return results.map {|type| Type.new(type)}
  end

  def self.find(id)
    sql = "SELECT * FROM types WHERE id = #{id}"
    results = SqlRunner.run(sql).first
    return Type.new(results)
  end

end