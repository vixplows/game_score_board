require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/session.rb')
require_relative('../models/session.rb')

get '/sessions' do
  @sessions = Session.all()
  @games = Game.all()
  erb(:"sessions/index")
end

get '/sessions/new' do
  @games = Game.all()
  @players = Player.all()
  erb(:"sessions/new")
end

post '/sessions' do
  @games = Game.all()
  Session.new(params).save
  redirect to '/sessions'
end

get '/sessions/:id' do
  @session = Session.find(params['id'])
  @results = @session.results()
  erb(:"sessions/show")
end