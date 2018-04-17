class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    update_pin = PinService.new.toggle_pin_for pin_code

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
