require 'csv'

class PinService

  def initialize
    @pins = []
    CSV.foreach(Rails.root.join('pins.csv')) do |row|
      @pins << { pin: row[0], output: row[1].to_i }
    end

    def for pin_code
      @pins.select { |pin| pin[:pin] == pin_code }.first[:output]
    end
  end
end
