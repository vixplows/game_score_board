require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/player_session.rb')
require_relative('../models/result.rb')

# refactored code to use different routing rather than requesting referral path
get '/sessions/:id/player/new' do
  @session = Session.find('id')
  @game = Game.find(@session.game_id.to_i)
  @results = Result.all()
  @players = Player.all()
  erb(:"sessions_players/new")
end

post '/sessions/players' do
  PlayerSession.new(params).save
  redirect to '/sessions'
end