require 'csv'

class PinService

  attr_reader :pins

  def initialize
    @pins = []
    @path = Rails.root.join('pins.csv')
    CSV.foreach(@path) do |row|
      @pins << { pin: row[0], output: row[1].to_i, state: to_bool(row[2]) }
    end
  end

  private def pin_for pin_code
    @pins.select { |pin| pin[:pin] == pin_code }.first
  end

  def toggle_for pin_code
    @selected_pin = pin_for(pin_code)
    return false unless @selected_pin

    save_pin_state
    ArduinoService.instance.set_led @selected_pin[:output], @selected_pin[:state]
  end

  def reset_all_pins
    @pins.each do |pin|
      ArduinoService.instance.set_led pin[:output], pin[:state]
    end
  end

  private def save_pin_state
    @selected_pin[:state] = (@selected_pin[:state] ? false : true)
    csv = CSV.generate do |csv|
      @pins.each do |pin|
        csv << [pin[:pin],pin[:output],pin[:state]]
      end
    end
    File.write(@path, csv)
  end

  private def to_bool value
    return true if (value == 'true')
    return false
  end

end
