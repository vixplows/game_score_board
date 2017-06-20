require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/player_session.rb')
require_relative('../models/result.rb')
require_relative('../models/session.rb')

get '/sessions/:id/player/new' do
  @session = Session.find(params['id'])
  @game = Game.find(@session.game_id.to_i)
  @results = Result.all()
  @players = Player.all()
  erb(:"sessions_players/new")
end

post '/sessions/:id/player/new' do
  player_session = PlayerSession.new(params)
  player_session.save()
  redirect to "/sessions/#{params['id']}"
end

get '/players_sessions/:id/edit' do
  @player_session = PlayerSession.find(params['id'])
  erb(:"sessions_players/edit")
end

post '/player_sessions/:id//edit' do
  player_session = PlayerSession.new(params)
  player_session.update
  redirect to "/sessions/#{params['id']}"
end