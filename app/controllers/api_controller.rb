class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    leds = ArduinoService.instance.leds
    pin_1 = { pin: "1234", output: leds[1] }
    pin_2 = { pin: "1235", output: leds[2] }
    pin_3 = { pin: "0987", output: leds[3] }

    selected = [pin_1, pin_2, pin_3].select { |pin| pin[:pin] == pin_code.join }.first

    if selected
      selected[:output].send(:on)
      return render json: {}, status: 202
    else
      puts "ERROR"
      return render json: {}, status: 403
    end
  end

  private def pin_code
    params['_json']
  end
end
