class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    pin_1 = { pin: "1234", output: 2 }
    pin_2 = { pin: "1235", output: 3 }
    pin_3 = { pin: "0987", output: 4 }

    selected = [pin_1, pin_2, pin_3].select { |pin| pin[:pin] == pin_code.join }.first

    if selected
      ArduinoService.instance.toggle_led selected[:output]
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
