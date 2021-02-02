class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      # login user
    else
      #unable to save
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :password)
  end
end
