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

  def type
    sql = "SELECT types.name FROM types, games WHERE types.id = games.type_id AND games.id = #{id}"
    result = SqlRunner.run(sql).first
    return result['name']
  end

  def session_list
    sql = "select * from games, sessions where sessions.game_id = games.id and games.id = #{id}"
    results = SqlRunner.run(sql)
    sessions = results.map {|session| Session.new(session)}
    return sessions
    #list all sessions of this game that have been played in session view - see code in sessions that does this.
  end

#return number of session plays of a game.
  def sessions()
    sql = "SELECT * FROM sessions, games WHERE sessions.game_id = games.id AND games.id = #{id}"
    sessions = SqlRunner.run(sql)
    return sessions.count
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