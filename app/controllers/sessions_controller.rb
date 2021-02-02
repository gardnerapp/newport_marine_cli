class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(phone: params[:session][:log])
    if user&.authenticate(params[:session][:password])
      log_in user
      # returns user for the app
      render json: user
    else
      render json: {message: "No User Found"}
    end
  end
end
