class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    output = PinService.new.for pin_code

    if output
      ArduinoService.instance.toggle_led output
      return render json: {}, status: 202
    else
      puts "ERROR"
      return render json: {}, status: 403
    end
  end

  private def pin_code
    params['_json'].join
  end
end
