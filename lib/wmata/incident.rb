module WMATA
  class Incident
    
    # {
    #   "DateUpdated"=>"/Date(1371247167000+0000)/", 
    #   "DelaySeverity"=>nil, 
    #   "Description"=>"Red Line: Buses replace trains btwn Rhode Island Ave & Forest Glen stations until Sunday’s closing. Bus service is provided.", 
    #   "EmergencyText"=>nil, 
    #   "EndLocationFullName"=>nil, 
    #   "IncidentID"=>"D3DDDB5D-47E2-4BBE-B13A-2A4E5876ACF8", 
    #   "IncidentType"=>"Delay", 
    #   "LinesAffected"=>"RD;", 
    #   "PassengerDelay"=>0, 
    #   "StartLocationFullName"=>nil
    # }
    
    attr_accessor :id, :type, :description, :date_updated,
      :emergency_text, :start_station, :end_station, 
      :delay, :lines_affected, :severity

    def initialize(station)
      @id = station['IncidentID']
      @type = station['IncidentType']
      @description = station['Description']
      @emergency_text = station['EmergencyText']
      @lines_affected = station['LinesAffected'].split(';')
      @severity = station['DelaySeverity']
      @delay = station['PassengerDelay']
      @date_updated = station['DateUpdated']
    end

    def updated
      @date_updated
      # @updated ||= Time.parse(@date_updated.match(/(\d+\+\d+)/)[1])
    end

    def to_s
      @description
    end

    def emergency?
      !emergency_text.nil?
    end

  end
end