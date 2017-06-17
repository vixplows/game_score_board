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
  "name" => "Strategy"
  })

type1.save()

type2 = Type.new({
  "name" => "Card"
  })

type2.save()

type3 = Type.new({
  "name" => "Word"
  })

type3.save()

type4 = Type.new({
  "name" => "Trivia"
  })

type4.save()

type5 = Type.new ({
  "name" => "Dice"
  })

game1 = Game.new({
  "name" => "Scrabble",
  "type_id" => type3.id
  })

game1.save()

game2 = Game.new({
  "name" => "Discworld: Ankh-Morpork",
  "type_id" => type1.id
  })

game2.save()

game3 = Game.new({
  "name" => "Carcassonne",
  "type_id" => type1.id
  })

game3.save()

game4 = Game.new({
  "name" => "Trivial Pursuit, Genus Edition",
  "type_id" => type4.id
  })

game4.save()

game5 = Game.new({
  "name" => "Exploding Kittens",
  "type_id" => type2.id
  })

game5.save()

game6 = Game.new({
  "name" => "Monopoly Deal",
  "type_id" => type2.id
  })

game6.save()

game7 = Game.new ({
  "name" => "The Settles of Catan",
  "type_id" => type1.id
  })

game7.save()

game8 = Game.new ({
  "name" => "Trivial Pursuit, Millenium Edition",
  "type_id" => type4.id
  })

game8.save()

game9 = Game.new ({
  "name" => "7 Wonders",
  "type_id" => type1.id
  })

game9.save()

game10 = Game.new ({
  "name" => "Yahtzee",
  "type_id" => type5.id
  })

game10.save()

result1 = Result.new ({
  "tag" => "Won"
  })

result1.save()

result2 = Result.new ({
  "tag" => "Lost"
  })

result2.save()

result3 = Result.new ({
  "tag" => "Drew"
  })

result3.save()