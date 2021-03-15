class PasswordResetsController < ApplicationController
  before_action :get_user, only: %i[edit update]
  before_action :check_expiration, only: %i[edit update]
  protect_from_forgery except: :create

  # POST /password_resets ** password_resets
  def create 
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      render json: 'Password Reset Sent', status: :accepted
    else 
      render json: 'No User Could Be Located', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if params[:email].empty?
      @user.errors.add(:password, "Can't be empty")
      render 'edit'
    elsif @user.update(user_params)
      render 'success'
    else
      render 'edit'
    end
  end

  def success
  end

  # TODO get Customer Service
  def error
  end



  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user 
    @user = User.find_by(email: params[:email].downcase)
  end
  
  def check_expiration 
    if @user.password_reset_expired?
      # TODO Render Reset has expired :)
    end
  end
  
end
