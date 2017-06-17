require_relative ('../models/game.rb')
require_relative ('../models/player.rb')
require_relative ('../models/player_session.rb')
require_relative ('../models/result.rb')
require_relative ('../models/session.rb')
require_relative ('../models/type.rb')
require('pry-byebug')

PlayerSession.delete_all
Session.delete_all
Player.delete_all
Result.delete_all
Game.delete_all
Type.delete_all

type1 = Type.new({
  "name" => "strategy"
  })

type1.save

type2 = Type.new({
  "name" => "card"
  })

type2.save

type3 = Type.new({
  "name" => "word"
  })

type3.save

type4 = Type.new({
  "name" => "trivia"
  })

type4.save

