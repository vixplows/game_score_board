require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/player_session.rb')
require_relative('../models/result.rb')

# renaming resource as sessions_players as makes more sense as players is nested within the sessions
# get '/sessions/:id/player/new' do
# end

get '/players_sessions/new' do
  @session_id = request.referer.split('/').last
  @session = Session.find(@session_id.to_i)
  @game = Game.find(@session.game_id.to_i)
  @results = Result.all()
  @players = Player.all()
  erb(:"players_sessions/new")
end

post '/players_sessions' do
  PlayerSession.new(params).save
  redirect to '/sessions'
end

# in get players / post players form need to include the relevant session id this is the id from the url on the previous page "/sessions/:id where the link to the 'add player result' came from