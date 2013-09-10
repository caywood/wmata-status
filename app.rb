require 'sinatra'
require "sinatra/reloader" if development?
require 'wmata'
# require './lib/wmata'

WMATA.api_key = ENV['WMATA_API_KEY']

set :haml, { format: :html5, attr_wrapper: '"' }

helpers do
  def pluralize(n, singular, plural=nil)
    if n == 1 
      "1 #{singular}"
    elsif plural
      "#{n} #{plural}"
    else
      "#{n} #{singular}s"
    end
  end
end

get '/' do
  @lines = WMATA.lines
  haml :index
end

get '/debug' do
  @lines = WMATA.lines
  @stations = WMATA.stations
  @incidents = WMATA.incidents
  haml :debug
end

get '/station/:code' do
  @station = WMATA.station(params[:code])
  haml :station
end

get '/line/:code' do
  @line = WMATA::Line.get(params[:code].to_sym)
  haml :line
end