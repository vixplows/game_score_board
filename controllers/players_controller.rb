require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/player.rb')

get '/players' do
  @players = Player.all()
  erb(:"players/index")
end

get '/players/new' do
  erb(:"players/new")
end

post '/players' do
  Player.new(params).save
  redirect to '/players'
end

get '/players/:id' do
  @player = Player.find(params['id'])
  @result = @player.games()
  erb(:"players/show")
end