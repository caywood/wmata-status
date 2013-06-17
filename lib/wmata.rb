$LOAD_PATH << File.dirname(__FILE__)

require 'rest_client'
require 'multi_json'

require "wmata/line"
require "wmata/station"
require "wmata/incident"

module WMATA
  LINES = {
    "red" => "RD",
    "orange" => "OR",
    "blue" => "BL",
    "green" => "GR",
    "yellow" => "YL"
  }

  ENDPOINT = "http://api.wmata.com/"

  def self.get_line_code(str)
    if LINES.has_key?(str.downcase)
      LINES[str.downcase]
    elsif LINES.has_value?(str.upcase)
      str
    else
      nil
    end
  end

  def self.get(resource, params={})
    params = params.merge(:api_key => ENV['WMATA_API_KEY'])

    full_path = ENDPOINT + resource

    response = RestClient.get(full_path, { :params => params })

    MultiJson.decode(response)
  end
  
  def self.lines
    response = get('Rail.svc/json/jLines')
    if response.has_key?("Lines")
      return Hash[response["Lines"].map do |l|
        line = Line.new(l)
        [line.code, line]
      end]
    end
  end

  def self.line(code)
    return self.lines[code]
  end

  def self.stations(line=nil)
    response = get('Rail.svc/json/jStations', 'LineCode' => line)
    if response.has_key?("Stations")
      return response["Stations"].map { |station| Station.new(station) }
    end
  end

  def self.station(code)
    response = get('Rail.svc/json/jStationInfo', 'StationCode' => code)
    return Station.new(response)
  end

  def self.incidents
    response = get('Incidents.svc/json/Incidents')
    if response.has_key?("Incidents")
      return response["Incidents"].map { |incident| Incident.new(incident) }
    end
  end

  def self.incidents_for_line(line)
    incidents_by_line = Hash[LINES.map { |slug, code| [ code, [] ] }]
    
    self.incidents.each do |incident|
      incident.lines_affected.each do |line|
        incidents_by_line[line] << incident
      end
    end

    incidents_by_line[line]
  end

end