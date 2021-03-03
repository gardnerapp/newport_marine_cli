class UsersController < ApplicationController
  before_action :set_user, only: %i[show]
  #GET /users
  def index
    @user = User.all
  end

  # GET /users/:id
  def show
    @boat = @user.boat
    @appointments = @user.appointments.all
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone,
                                 :password_digest, :password_confirmation)
  end

end
