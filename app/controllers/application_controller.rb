class ApplicationController < ActionController::Base
  include UsersHelper

  def home
    @appointments = Appointment.all
    render 'layouts/home'
  end
end
