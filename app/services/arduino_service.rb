require 'singleton'

class ArduinoService

  include Singleton

  def initialize
    @serial = Dino::TxRx::Serial.new(baud: 9600)

    while @board.nil?
      begin
        @board = Dino::Board.new(@serial)
      rescue Dino::BoardNotFound
        puts 'Reload board'
        sleep 5
      end
    end
  end

  def leds
    @leds = {}
    (2..17).each do |number|
      @leds[number] = Dino::Components::Led.new(pin: number, board: @board)
    end
    @leds
  end
end
