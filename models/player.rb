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

# trying to return an array of hashes of all the existing players_sessions associated with one player
  def session()
    sql = "SELECT * FROM players_sessions INNER JOIN players
      ON players.id = players_sessions.player_id
      WHERE players_sessions.player_id = #{id}"
  players_sessions = SqlRunner.run(sql)
  return players_sessions.values
  end

# # want number of total games won for individual player
#   def won()
#     # select all rows for a specific player from the player_sessions table where the player_id matches the players id in the players table
#     sql = "SELECT * FROM players_sessions INNER JOIN players ON players.id = players_sessions.player_id WHERE players_sessions.player_id = #{@player.id}"
#     player_sessions = SqlRunner(sql).first
#     return Player.new(player_sessions)
#     # select all result_id that are a win in the associated results table
#     # save result_ids == to a win in a win_results array
#     # return a count of the total number in the win_results array
#     # show win totals for each player in leader board table on homepage and in player details on player performance page but with game details too in the latter
#   end

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