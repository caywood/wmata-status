require 'sinatra'
require "sinatra/reloader" if development?
require './lib/wmata'

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
  @lines = WMATA::LINES
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
  code = WMATA.get_line_code(params[:code])
  
  if code.nil?
    puts "Invalid line specified."
    halt 404
  end

  @line = WMATA.line(code)
  haml :line
end