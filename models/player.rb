require_relative('../db/sql_runner')
require('pry-byebug')

class Player

  attr_reader :id, :name, :image
    
  def initialize(options)
    @id = nil || options['id'].to_i
    @name = options['name']
    @image = options['image']
  end

  def save()
    sql = "INSERT INTO players (name, image) VALUES ('#{@name}', '#{@image}') RETURNING *"
    results = SqlRunner.run(sql).first
    @id = results['id'].to_i
  end

  def update()
    sql = "UPDATE players SET (name, image) = ('#{@name}', '#{@image}') WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM players WHERE players.id = #{id}"
    SqlRunner.run(sql)
  end

  def message()
    result = (won.to_f / play.to_f) * 100
    if result >= 70
      return "what a ** WINNER! **"
    elsif result >= 40
      return "what a ** PLAYER! **"
    else return "what a ** LOSER! **"
    end
  end

  def play()
    sql = "SELECT * FROM players_sessions
        INNER JOIN players ON players_sessions.player_id = players.id
        WHERE players.id = #{id}
        ORDER BY players_sessions.points DESC"
    plays = SqlRunner.run(sql)
    return plays.count.to_i
  end

  def latest_session()
    sql = "SELECT games.name, sessions.date FROM players_sessions
      INNER JOIN players ON players_sessions.player_id = players.id
      INNER JOIN sessions ON players_sessions.session_id = sessions.id
      INNER JOIN games ON sessions.game_id = games.id
      WHERE players.id = #{id}
      ORDER BY date DESC"
    results = SqlRunner.run(sql).first
    return results
  end

  def sessions()
    sql = "SELECT games.name, sessions.date, results.tag, sessions.id, players_sessions.points FROM players_sessions
      INNER JOIN players ON players_sessions.player_id = players.id
      INNER JOIN results ON players_sessions.result_id = results.id
      INNER JOIN sessions ON players_sessions.session_id = sessions.id
      INNER JOIN games ON sessions.game_id = games.id
      WHERE players.id = #{id} ORDER BY date DESC"
    results = SqlRunner.run(sql)
    return results
  end

  def games()
    sql = "SELECT DISTINCT games.* FROM players_sessions
      INNER JOIN players ON players_sessions.player_id = players.id
      INNER JOIN sessions ON players_sessions.session_id = sessions.id
      INNER JOIN games ON sessions.game_id = games.id
      WHERE players.id = #{id} ORDER BY name"
    results = SqlRunner.run(sql)
    return results.map {|game| Game.new(game)}
  end

  def won()
    sql = "SELECT * FROM players_sessions
      INNER JOIN players ON players_sessions.player_id = players.id
      INNER JOIN results ON players_sessions.result_id = results.id
      WHERE players.id = #{id} AND results.tag='Won'"
    wins = SqlRunner.run(sql)
    return wins.count
  end

  def lost()
    sql = "SELECT * FROM players_sessions
      INNER JOIN players ON players_sessions.player_id = players.id
      INNER JOIN results ON players_sessions.result_id = results.id
      WHERE players.id = #{id} AND results.tag='Lost'"
    losses = SqlRunner.run(sql)
    return losses.count
  end

  def drew()
    sql = "SELECT * FROM players_sessions
      INNER JOIN players ON players_sessions.player_id = players.id
      INNER JOIN results ON players_sessions.result_id = results.id
      WHERE players.id = #{id} AND results.tag='Drew'"
    draws = SqlRunner.run(sql)
    return draws.count
  end

  def in_progress()
    sql = "SELECT * FROM players_sessions
      INNER JOIN players ON players_sessions.player_id = players.id
      INNER JOIN results ON players_sessions.result_id = results.id
      WHERE players.id = #{id} AND results.tag='In progress'"
    draws = SqlRunner.run(sql)
    return draws.count
  end

  def points_total()
    sql = "SELECT players_sessions.points FROM players_sessions
      INNER JOIN players ON players_sessions.player_id = players.id
      WHERE players.id = #{id}"
    results = SqlRunner.run(sql)
    sum = 0
    results.each {|session_points| sum += session_points['points'].to_i}
    return sum
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

  def self.top_three_winners()
  sql = "SELECT players.name, count(*) as wins FROM players_sessions
      INNER JOIN players ON players_sessions.player_id = players.id
      INNER JOIN results ON players_sessions.result_id = results.id
      WHERE results.tag = 'Won' GROUP BY players.name ORDER BY wins DESC LIMIT 3"
  winners = SqlRunner.run(sql)
  return winners
  end

  def self.top_three_losers()
    sql = "SELECT players.name, count(*) as losses FROM players_sessions
        INNER JOIN players ON players_sessions.player_id = players.id
        INNER JOIN results ON players_sessions.result_id = results.id
        WHERE results.tag = 'Lost' GROUP BY players.name ORDER BY losses DESC LIMIT 3"
    losers = SqlRunner.run(sql)
    return losers
  end
end