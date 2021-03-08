class ApplicationController < ActionController::Base
  include SessionsHelper

  # Go to home, if not signed in redirect to sessions/new
  # if signed in render admin home screen

  def home
    if current_user == nil
      redirect_to login_path
    else
      @appointments = Appointment.all
      render 'layouts/home'
    end
  end

end
