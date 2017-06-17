require('pg')

class SqlRunner

  def self.run(sql)
    begin
      db = PG.connect({dbname: 'game_score_board', host: 'localhost'})
      result = db.exec(sql)
    ensure
      db.close
    end
     return result
  end

end