require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/player.rb')

get '/players' do
  @players = Player.all()
  erb(:"players/index")
end