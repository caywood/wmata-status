$LOAD_PATH << File.dirname(__FILE__)

require 'rest_client'
require 'multi_json'

require "wmata/line"
require "wmata/station"

module WMATA
  ENDPOINT = "http://api.wmata.com/"

  def self.get(resource, params={})
    params = params.merge(:api_key => ENV['WMATA_API_KEY'])

    full_path = ENDPOINT + resource

    response = RestClient.get(full_path, { :params => params })

    MultiJson.decode(response)
  end
  
  def self.lines
    response = get('Rail.svc/json/jLines')
    if response.has_key?("Lines")
      return response["Lines"].map { |line| Line.new(line) }
    end
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
      return response["Incidents"]
    end
  end

end