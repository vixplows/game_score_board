require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/game.rb')

get '/games' do
  @games = Game.all()
  erb(:"games/index")
end

get '/games/:id' do
  @game = Game.find(params['id'])
  erb(:"games/show")
end