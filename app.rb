require 'sinatra'
require "sinatra/reloader" if development?

LINES = {
  "Red" => "RD",
  "Orange" => "OR",
  "Blue" => "BL",
  "Green" => "GR",
  "Yellow" => "YL"
}

# set :public_folder, File.dirname(__FILE__) + '/static'
set :haml, { format: :html5, attr_wrapper: '"' }

helpers do
  def ordinalize(number)
    if (11..13).include?(number % 100)
      "#{number}th"
    else
      case number % 10
        when 1
          "#{number}st"
        when 2
          "#{number}nd"
        when 3
          "#{number}rd"
        else
          "#{number}th"
      end
    end
  end
end

get '/' do
  @lines = LINES
  haml :index
end