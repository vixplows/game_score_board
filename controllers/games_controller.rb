require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/game.rb')
require_relative('../models/type.rb')

get '/games' do
  @games = Game.all()
  games_sort = @games.sort_by!(&:name)
  erb(:"games/index")
end

get '/games/new' do
  @types = Type.all()
  erb(:"games/new")
end

post '/games' do
  Game.new(params).save
  redirect to '/games'
end

get '/games/:id' do
  @game = Game.find(params['id'])
  @sessions = @game.session_list()
  # @results = @game.score_cards()
  erb(:"games/show")
end