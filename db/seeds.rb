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

result4 = Result.new ({
  "tag" => "In progress"
  })

result4.save()

player1 = Player.new ({
  "name" => "Jezza"
  })

player1.save()

player2 = Player.new ({
  "name" => "Theresa"
  })

player2.save()

player3 = Player.new ({
  "name" => "Po"
  })

player3.save()

player4 = Player.new ({
  "name" => "Dipsy"
  })

player4.save()

session1 = ({
  "game_id" => game1(id),
  "date" => "2017-06-17",
  "start_time" => "16:05",
  "finish_time" => "17:45"
  })

session1.save()

session2 = ({
  "game_id" => game2(id),
  "date" => "2017-06-14",
  "start_time" => "18:30",
  "finish_time" => "19:30"
  })

session2.save()

session3 = ({
  "game_id" => game3.id,
  "date" => "2017-06-02",
  "start_time" => "13:00",
  "finish_time" => "14:10"
  })

session3.save()

session4 = ({
  "game_id" => game4.id,
  "date" => "2017-04-24",
  "start_time" => "19:45",
  "finish_time" => "20:33"
  })

session4.save()

session5 = ({
  "game_id" => game5.id,
  "date" => "2016-12-10",
  "start_time" => "21:10",
  "finish_time" => "22:20"
  })

session5.save()

session6 = ({
  "game_id" => game3.id,
  "date" => "2016-12-10",
  "start_time" => "20:00",
  "finish_time" => "20:55"
  })

session6.save

player_session1 = ({
  "player_id" => player1.id,
  "session_id" => session1.id,
  "result_id" => result1.id,
  "points" => 201
  })

player_session1.save()

player_session2 = ({
  "player_id" => player2.id,
  "session_id" => session1.id,
  "result_id" => result2.id,
  "points" => 101
  })

player_session2.save()

player_session3 = ({
  "player_id" => player1.id,
  "session_id" => session2.id,
  "result_id" => result1.id,
  "points" => 99
  })

player_session3.save()

player_session4 = ({
  "player_id" => player2.id,
  "session_id" => session2.id,
  "result_id" => result2.id,
  "points" => 64
  })

player_session4.save()

player_session5 = ({
  "player_id" => player1.id,
  "session_id" => session3.id,
  "result_id" => result2.id,
  "points" => 87
  })

player_session5.save()

player_session6 = ({
  "player_id" => player3.id,
  "session_id" => session3.id,
  "result_id" => result1.id,
  "points" => 94
  })

player_session6.save()

player_session7 = ({
  "player_id" => player3.id,
  "session_id" => session4.id,
  "result_id" => result1.id,
  "points" => nil
  })

player_session7.save()

player_session8 = ({
  "player_id" => player4.id,
  "session_id" => session4.id,
  "result_id" => result2.id,
  "points" => nil
  })

player_session8.save()

player_session9 = ({
  "player_id" => player1.id,
  "session_id" => session5.id,
  "result_id" => result4.id,
  "points" => nil
  })

player_session9.save()

player_session10 = ({
  "player_id" => player4.id,
  "session_id" => session5.id,
  "result_id" => result4.id,
  "points" => nil
  })

player_session10.save()

player_session11 = ({
  "player_id" => player2.id,
  "session_id" => session6.id,
  "result_id" => result3.id,
  "points" => nil
  })

player_session11.save()

player_session12 = ({
  "player_id" => player3.id,
  "session_id" => session6.id,
  "result_id" => result3.id,
  "points" => nil
  })

player_session12.save()