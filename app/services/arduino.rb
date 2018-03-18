class Arduino
  include Singleton

  serial = Dino::TxRx::Serial.new(baud: 9600)

  begin
    board = Dino::Board.new(serial)
  rescue Dino::BoardNotFound
    puts 'Reload board'
  end

  sleep 5
  puts 'Go!'

  board = Dino::Board.new(serial)
  led1 = Dino::Components::Led.new(pin: 2, board: board)
  led2 = Dino::Components::Led.new(pin: 3, board: board)
  led3 = Dino::Components::Led.new(pin: 4, board: board)


  pin_1 = { pin: "1234", output: led1 }
  pin_2 = { pin: "1235", output: led2 }
  pin_3 = { pin: "0987", output: led3 }


  loop do
    puts 'Enter your code: '
    input = gets.chomp

    selected = [pin_1, pin_2, pin_3].select { |pin| pin[:pin] == input }.first

    if selected
      selected[:output].send(:on)
      sleep 2
      selected[:output].send(:off)
    else
      puts 'err'
    end

  end
end
