require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/game.rb')

get '/games' do
  @games = Game.all()
  erb(:"games/index")
end

#brings back all sessions - want to bring back only sessions with session games_id that matches the id in the params
get '/games/:id' do
  @game = Game.find(params['id'])
  @sessions = @game.session_list()
  erb(:"games/show")
end