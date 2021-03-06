require('sinatra')
require('sinatra/contrib/all')
require_relative('controllers/games_controller.rb')
require_relative('controllers/players_controller.rb')
require_relative('controllers/sessions_controller.rb')
require_relative('controllers/sessions_players_controller.rb')

get '/' do
  @players = Player.all()
  @players.sort_by!(&:name)
  @winners = Player.top_three_winners()
  @losers = Player.top_three_losers()
  erb(:index)
end