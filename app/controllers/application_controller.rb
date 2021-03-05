class ApplicationController < ActionController::Base
  include SessionsHelper
  def home
    # TOOD If User logged in display something if not display fuck u
    @appointments = Appointment.all
    render 'layouts/home'
  end
end
