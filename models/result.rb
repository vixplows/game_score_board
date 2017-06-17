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

end