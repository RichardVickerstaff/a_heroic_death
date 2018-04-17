class AppController < ApplicationController

  def admin
    if pin_code
      PinService.new.toggle_for pin_code
    end
  end

  private def pin_code
    params['pin_code']
  end
end
