require 'singleton'

class ArduinoService

  include Singleton

  def initialize
    @serial = Dino::TxRx::Serial.new(baud: 9600)

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

  def set_led number, state
    led = leds[number]
    if state
      led[:led].off
    else
      led[:led].on
    end
  end

  private def leds
    if @leds.nil?
      board = Dino::Board.new(@serial)
      @leds = {}
      (2..17).each do |number|
        @leds[number] = { led: Dino::Components::Led.new(pin: number, board: board) }
      end
    end
    @leds
  end
end
