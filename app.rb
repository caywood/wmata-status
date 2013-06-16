require 'sinatra'
require "sinatra/reloader" if development?
require './lib/wmata'

LINES = {
  "Red" => "RD",
  "Orange" => "OR",
  "Blue" => "BL",
  "Green" => "GR",
  "Yellow" => "YL"
}

set :haml, { format: :html5, attr_wrapper: '"' }

get '/' do
  @lines = LINES
  haml :index
end

get '/debug' do
  @lines = WMATA.lines
  @stations = WMATA.stations
  haml :debug
end

get '/station/:code' do
  @station = WMATA.station(params[:code])
  haml :station
end