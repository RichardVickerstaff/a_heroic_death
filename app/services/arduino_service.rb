require 'singleton'

class ArduinoService

  include Singleton

  def initialize
    @serial = Dino::TxRx::Serial.new(baud: 115200)

    board = nil
    while board.nil?
      begin
        board = Dino::Board.new(@serial)
      rescue Dino::BoardNotFound
        puts 'Reload board'
        sleep 5
      end
    end
  end

  def toggle_led number
    led = leds[number]
    on = led[:on]
    if on
      led[:led].off
      led[:on] = false
    else
      led[:led].on
      led[:on] = true
    end
  end

  private def leds
    if @leds.nil?
      board = Dino::Board.new(@serial)
      @leds = {}
      (2..17).each do |number|
        @leds[number] = { led: Dino::Components::Led.new(pin: number, board: board), on: false }
      end
    end
    @leds
  end
end
