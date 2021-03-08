class UsersController < ApplicationController
  before_action :set_user, only: %i[show]
  before_action :authenticate
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

  def authenticate
    redirect_to login_path if current_user.nil? || !current_user.is_admin?
  end

end
