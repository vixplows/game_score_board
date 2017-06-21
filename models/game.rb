require_relative('../db/sql_runner')

class Game

  attr_reader :id, :name, :type_id, :image

  def initialize(options)
    @id = nil || options['id'].to_i
    @name = options['name']
    @type_id = options['type_id'].to_i
    @image = options['image']
  end

  def save()
    sql = "INSERT INTO games (name, type_id, image) VALUES ('#{@name}', #{@type_id}, '#{@image}') RETURNING *"
    results = SqlRunner.run(sql).first
    @id = results['id'].to_i
  end

  def type
    sql = "SELECT types.name FROM games
        INNER JOIN types ON types.id = games.type_id
        WHERE games.id = #{id}"
    result = SqlRunner.run(sql).first
    return result['name']
  end

  def players
    sql = "SELECT DISTINCT players.* FROM players_sessions
        INNER JOIN players ON players.id = players_sessions.player_id
        INNER JOIN sessions ON players_sessions.session_id = sessions.id
        INNER JOIN games ON sessions.game_id = games.id
        WHERE games.id = #{id}"
    SqlRunner.run(sql)
    results = SqlRunner.run(sql)
    return results.map {|player| Player.new(player)}
  end

#show score_card assocaited with this game_id via the player_sessions table
  def score_cards
    sql = "SELECT players.name, sessions.date, players_sessions.points, results.tag, sessions.id FROM players_sessions
        INNER JOIN players ON players_sessions.player_id = players.id
        INNER JOIN sessions ON players_sessions.session_id = sessions.id
        INNER JOIN results ON players_sessions.result_id = results.id
        INNER JOIN games ON sessions.game_id = games.id
        WHERE games.id = #{id}
        ORDER BY sessions.date DESC"
    results = SqlRunner.run(sql)
    return results
  end

# to return all info from sessions table for sessions with specified game id
  def session_list
    sql = "SELECT * FROM sessions
      INNER JOIN games ON sessions.game_id = games.id
      WHERE games.id = #{id}
      ORDER BY sessions.date DESC"
    sessions = SqlRunner.run(sql)
    return sessions
  end

#return number of session plays of a game.
  def sessions()
    sql = "SELECT * FROM sessions INNER JOIN games ON sessions.game_id = games.id WHERE games.id = #{id}"
    sessions = SqlRunner.run(sql)
    return sessions.count
  end

  def delete()
    sql = "DELETE FROM games WHERE games.id = #{id}"
    SqlRunner.run(sql)
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