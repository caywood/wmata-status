require 'sinatra'
require "sinatra/reloader" if development?

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