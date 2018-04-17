class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if pin_code == '0000'
      PinService.new.reset_all_pins
      update_pin = true
    else
      update_pin = PinService.new.toggle_for pin_code
    end

    if update_pin
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
