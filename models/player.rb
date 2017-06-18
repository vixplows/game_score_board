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

# want number of total games won for individual player
  def won()
    # get all the result_id for a player from players_sessions table
    # select all result_id that are a win in the associated results table
    # save result_ids == to a win in a win_results array
    # return a count of the total number in the win_results array
    # show win totals for each player in leader board table on homepage and in player details on player performance page
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

  def self.find(id)
    sql = "SELECT * FROM players WHERE id = #{id}"
    results = SqlRunner.run(sql).first
    return Player.new(results)
  end


end