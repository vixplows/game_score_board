require('sinatra')
require('sinatra/contrib/all')
require_relative('controllers/games_controller.rb')
require_relative('controllers/players_controller.rb')
require_relative('controllers/players_sessions_controller.rb')
require_relative('controllers/results_controller.rb')
require_relative('controllers/sessions_controller.rb')
require_relative('controllers/types_controller.rb')

get '/' do
  erb(:index)
end