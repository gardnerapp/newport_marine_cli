class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      # Check is User.is_admin? & Login if soelse redirect
      log_in user
      redirect_to root_path
    else 
      flash.now[:danger] = 'Invalid Email/Password'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end



end
