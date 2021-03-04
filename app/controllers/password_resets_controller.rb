class PasswordResetsController < ApplicationController
  before_action :get_user, only: %i[edit update]
  before_action :check_expiration, only: %i[edit update]

  # TODO ADD CUSTOMER SERVICE CONTACT TO SUCCESS TO
  # In flutter user clicks forgot password
  # they enter their email, a POST req w email is sent to the create action
  # the create action finds user, creates reset digest & sends the email
  # the user clicks the link in the email, edit controller is rendered
  # new password, confirmation are entered in edit and PATCH req w update is sent

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
    # TODO Look IN Book Edit to see if I need to add any flashing to the views
    if params[:user][:email].empty?
      @user.errors.add(:password, "Can't be empty")
      render 'edit'
    elsif @user.update(user_params)
      redirect_to success_path
    else
      render 'edit'
    end
  end

  def success
  end
  
  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user 
    @user = User.find_by(email: params[:email])
  end
  
  def check_expiration 
    if @user.password_reset_expired?
      # TODO Render Reset has expired :)
    end
  end
  
end
