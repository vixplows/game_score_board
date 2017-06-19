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

post '/sessions/:id' do
  PlayerSession.new(params).save
  redirect to '/sessions'
end

get '/sessions/:id/player/edit' do
  @session = Session.find(params['id'])
  erb(:"sessions_players/edit")
end