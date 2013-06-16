module WMATA
  class Line
    attr_accessor :name, :code

    def initialize(line)
      @name = line['DisplayName']
      @code = line['LineCode']
    end

    def to_s
      @name
    end
  end
end