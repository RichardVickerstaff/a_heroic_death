class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if pin_code == %w[1 2 3 4]
      puts "SUCCECSS"
      render json: {}, status: 202
    else
      puts "ERROR"
      render json: {}, status: 403
    end
  end

  private def pin_code
    params['_json']
  end
end
