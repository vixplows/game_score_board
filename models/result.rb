require_relative('../db/sql_runner')

class Result

  attr_reader :id, :tag

  def initialize(options)
    @id = nil || options['id'].to_i
    @tag = options['tag']
  end

  def save()
    sql = "INSERT INTO results (tag) VALUES ('#{tag}') RETURNING *"
    results = SqlRunner.run(sql).first
    @id = results['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM results"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM results"
    results = SqlRunner.run(sql)
    return results.map {|result| Result.new(result)}
  end

  def self.find(id)
    sql = "SELECT * FROM results WHERE id = #{id}"
    results = SqlRunner.run(sql).first
    return Result.new(results)
  end


end