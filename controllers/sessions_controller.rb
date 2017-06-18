require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/session.rb')

get '/sessions' do
  @sessions = Session.all()
  erb(:"sessions/index")
end