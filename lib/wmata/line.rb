module WMATA
  class Line
    attr_accessor :name, :code, :incidents

    def initialize(line)
      @name = line['DisplayName']
      @code = line['LineCode']
    end

    def to_s
      "#{@name} Line"
    end

    def slug
      @name.downcase
    end

    def incidents
      @incidents ||= WMATA.incidents_for_line(@code)
    end

    def incidents?
      return false if incidents.nil?
      incidents.any?
    end

  end
end