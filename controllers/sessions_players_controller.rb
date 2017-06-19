require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/player_session.rb')
require_relative('../models/result.rb')
require_relative('../models/session.rb')

# need to refactor code to use different routing rather than requesting referral path so making ues of id params and then also redirect bacj to that specific session/:id as makes more sense to do so!
get '/sessions/:id/player/new' do
  @session_id = request.referer.split('/').last
  @session = Session.find(@session_id.to_i)
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
  erb(:"sessions_players/edit")
end