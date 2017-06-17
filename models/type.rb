require_relative('../db/sql_runner')

class Type

  attr_reader :id, :name

  def initialize(options)
    @id = nil || options['id'].to_i
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO types (name) VALUE ('#{@name}') RETURNING *"
    results = SqlRunner.run(sql).first
    @id = results['id'].to_i
  end

end