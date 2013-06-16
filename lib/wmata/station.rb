module WMATA
  class Station
    # {
    #   "Code"=>"D08", 
    #   "Lat"=>38.8867090898, 
    #   "LineCode1"=>"BL", 
    #   "LineCode2"=>"OR", 
    #   "LineCode3"=>nil, 
    #   "LineCode4"=>nil, 
    #   "Lon"=>-76.9770889014, 
    #   "Name"=>"Stadium Armory", 
    #   "StationTogether1"=>"", 
    #   "StationTogether2"=>""
    # }
    
    attr_accessor :name, :code, :point, :lines, :together

    def initialize(station)
      @name = station['Name']
      @code = station['Code']
      @point = [station['Lat'], station['Lon']]

      @lines = station.map do |key,value|
        value if key =~ /^LineCode/
      end.compact

      @together = station.map do |key,value|
        if key =~ /^StationTogether/
          value.empty? ? nil : value
        end
      end.compact
    end

    def to_s
      @name
    end

    def lat
      point.first
    end

    def lon
      point.last
    end

  end
end