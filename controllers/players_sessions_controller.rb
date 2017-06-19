require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/player_session.rb')
require_relative('../models/result.rb')

get '/players_sessions/new' do
  @results = Result.all()
  @players = Player.all()
  erb(:"players_sessions/new")
end

post '/players_sessions' do
  PlayerSession.new(params).save
  redirect to '/sessions'
end