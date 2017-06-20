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
  erb(:"players/show")
end

get '/players/:id/edit' do
  @player = Player.find(params['id'])
  erb(:"players/edit")
end

post '/players/:id' do
  player = Player.new(params)
  player.update
  redirect to "/players/#{params['id']}"
end