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

type5.save()

game1 = Game.new({
  "name" => "Scrabble",
  "type_id" => type3.id,
  "image" =>  "/images/scrabble1.jpg"
  })

game1.save()

game2 = Game.new({
  "name" => "Discworld: Ankh-Morpork",
  "type_id" => type1.id,
  "image" =>  "/images/discworld.jpg"
  })

game2.save()

game3 = Game.new({
  "name" => "Carcassonne",
  "type_id" => type1.id,
  "image" =>  "/images/carcassonne.jpg"
  })

game3.save()

game4 = Game.new({
  "name" => "Trivial Pursuit, Genus Edition",
  "type_id" => type4.id,
  "image" =>  "/images/trivial1.jpg"
  })

game4.save()

game5 = Game.new({
  "name" => "Exploding Kittens",
  "type_id" => type2.id,
  "image" =>  "/images/kittens.jpg"
  })

game5.save()

game6 = Game.new({
  "name" => "Monopoly Deal",
  "type_id" => type2.id,
  "image" =>  "/images/deal.jpg"
  })

game6.save()

game7 = Game.new ({
  "name" => "The Settlers of Catan",
  "type_id" => type1.id,
  "image" =>  "/images/catan.jpg"
  })

game7.save()

game8 = Game.new ({
  "name" => "Trivial Pursuit, Millenium Edition",
  "type_id" => type4.id,
  "image" =>  "/images/trivial2.jpg"
  })

game8.save()

game9 = Game.new ({
  "name" => "7 Wonders",
  "type_id" => type1.id,
  "image" =>  "/images/wonders.jpg"
  })

game9.save()

game10 = Game.new ({
  "name" => "Yahtzee",
  "type_id" => type5.id,
  "image" =>  "/images/yahtzee.jpg"
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
  "name" => "Jezza",
  "image" => "/images/jezza.jpg"
  })

player1.save()

player2 = Player.new ({
  "name" => "Theresa",
  "image" => "/images/theresa.jpg"
  })

player2.save()

player3 = Player.new ({
  "name" => "Po",
  "image" => "/images/po.jpg"
  })

player3.save()

player4 = Player.new ({
  "name" => "Dipsy",
  "image" => "/images/dipsy.jpg"
  })

player4.save()

session1 = Session.new ({
  "game_id" => game1.id,
  "date" => "2017-06-17",
  "start_time" => "16:05",
  "end_time" => "20:45"
  })

session1.save()

session2 = Session.new ({
  "game_id" => game2.id,
  "date" => "2017-06-14",
  "start_time" => "18:30",
  "end_time" => "19:30"
  })

session2.save()

session3 = Session.new ({
  "game_id" => game3.id,
  "date" => "2017-06-02",
  "start_time" => "13:00",
  "end_time" => "14:10"
  })

session3.save()

session4 = Session.new ({
  "game_id" => game4.id,
  "date" => "2017-04-24",
  "start_time" => "19:45",
  "end_time" => "20:33"
  })

session4.save()

session5 = Session.new ({
  "game_id" => game5.id,
  "date" => "2016-12-10",
  "start_time" => "21:10",
  "end_time" => "22:20"
  })

session5.save()

session6 = Session.new ({
  "game_id" => game3.id,
  "date" => "2016-12-10",
  "start_time" => "20:00",
  "end_time" => "20:55"
  })

session6.save

session7 = Session.new ({
  "game_id" => game1.id,
  "date" => "2016-10-30",
  "start_time" => "20:00",
  "end_time" => "20:55"
  })

session7.save

session8 = Session.new ({
  "game_id" => game1.id,
  "date" => "2016-09-10",
  "start_time" => "21:00",
  "end_time" => "22:45"
  })

session8.save

player_session1 = PlayerSession.new ({
  "player_id" => player1.id,
  "session_id" => session1.id,
  "result_id" => result1.id,
  "points" => 201
  })

player_session1.save()

player_session2 = PlayerSession.new ({
  "player_id" => player2.id,
  "session_id" => session1.id,
  "result_id" => result2.id,
  "points" => 101
  })

player_session2.save()

player_session3 = PlayerSession.new ({
  "player_id" => player1.id,
  "session_id" => session2.id,
  "result_id" => result1.id,
  "points" => 99
  })

player_session3.save()

player_session4 = PlayerSession.new ({
  "player_id" => player2.id,
  "session_id" => session2.id,
  "result_id" => result2.id,
  "points" => 64
  })

player_session4.save()

player_session5 = PlayerSession.new ({
  "player_id" => player1.id,
  "session_id" => session3.id,
  "result_id" => result2.id,
  "points" => 87
  })

player_session5.save()

player_session6 = PlayerSession.new ({
  "player_id" => player3.id,
  "session_id" => session3.id,
  "result_id" => result1.id,
  "points" => 94
  })

player_session6.save()

player_session7 = PlayerSession.new ({
  "player_id" => player3.id,
  "session_id" => session4.id,
  "result_id" => result1.id,
  "points" => nil
  })

player_session7.save()

player_session8 = PlayerSession.new ({
  "player_id" => player4.id,
  "session_id" => session4.id,
  "result_id" => result2.id,
  "points" => nil
  })

player_session8.save()

player_session9 = PlayerSession.new ({
  "player_id" => player1.id,
  "session_id" => session5.id,
  "result_id" => result4.id,
  "points" => 24
  })

player_session9.save()

player_session10 = PlayerSession.new ({
  "player_id" => player4.id,
  "session_id" => session5.id,
  "result_id" => result4.id,
  "points" => 64
  })

player_session10.save()

player_session11 = PlayerSession.new ({
  "player_id" => player2.id,
  "session_id" => session6.id,
  "result_id" => result3.id,
  "points" => nil
  })

player_session11.save()

player_session12 = PlayerSession.new ({
  "player_id" => player3.id,
  "session_id" => session6.id,
  "result_id" => result3.id,
  "points" => nil
  })

player_session12.save()

player_session13 = PlayerSession.new ({
  "player_id" => player1.id,
  "session_id" => session7.id,
  "result_id" => result1.id,
  "points" => 145
  })

player_session13.save()

player_session14 = PlayerSession.new ({
  "player_id" => player3.id,
  "session_id" => session7.id,
  "result_id" => result2.id,
  "points" => 144
  })

player_session14.save()

player_session15 = PlayerSession.new ({
  "player_id" => player4.id,
  "session_id" => session8.id,
  "result_id" => result1.id,
  "points" => 145
  })

player_session15.save()

player_session16 = PlayerSession.new ({
  "player_id" => player3.id,
  "session_id" => session8.id,
  "result_id" => result2.id,
  "points" => 144
  })

player_session16.save()

player_session17 = PlayerSession.new ({
  "player_id" => player1.id,
  "session_id" => session8.id,
  "result_id" => result1.id,
  "points" => 125
  })

player_session17.save()

session1.update()

binding.pry
nil