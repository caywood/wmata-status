$LOAD_PATH << File.dirname(__FILE__)

require 'rest_client'
require 'multi_json'

# require "wmata/client"

module WMATA
  
  ENDPOINT = "http://api.wmata.com/"

  def self.get(resource, params={})
    params = params.merge(:api_key => ENV['WMATA_API_KEY'])

    full_path = ENDPOINT + resource

    response = RestClient.get(full_path, { :params => params })

    MultiJson.decode(response)
  end
  
  def self.lines
    # get all lines
    # jLines
    response = get('Rail.svc/json/jLines')
    if response.has_key?("Lines")
      return response["Lines"]
    end
  end

  def self.stations(line=nil)
    response = get('Rail.svc/json/jStations', 'LineCode' => line)
    if response.has_key?("Stations")
      return response["Stations"]
    end
  end

  def self.station(code)
    get('Rail.svc/json/jStationInfo', 'StationCode' => code)
  end

  def self.incidents
    response = get('Incidents.svc/json/Incidents')
    if response.has_key?("Incidents")
      return response["Incidents"]
    end
  end

end