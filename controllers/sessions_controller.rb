require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/session.rb')

get '/sessions' do
  @sessions = Session.all()
  @sessions_sort = @sessions.sort_by!(&:date).reverse!
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
  session = Session.new(params)
  session.save
  redirect to '/sessions'+'/'+session.id.to_s
end

get '/sessions/:id' do
  @session = Session.find(params['id'])
  @results = @session.results()
  erb(:"sessions/show")
end

get '/sessions/:id/edit' do
  @session = Session.find(params['id'])
  @games = Game.all()
  erb(:"sessions/edit")
end

post '/sessions/:id' do
  session = Session.new(params)
  session.update
  redirect to "/sessions/#{params['id']}"
end