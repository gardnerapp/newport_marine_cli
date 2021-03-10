class Api::UsersController < ActionController::API
  before_action :set_user, only: :show

  # POST /api/users
  # Make Sure to only return the remember_token and exclude the remember digestx
  def create
    @user = User.new(user_params)
    if @user.save
      @user.remember
      render json: { id: @user.id,
                     name: @user.name,
                     email: @user.email,
                     phone: @user.phone,
                     boat: @user.boat,
                     token: @user.remember_token }, status: :accepted
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def show
    if @user&.authenticated?(params[:token])
      @appointments = @user.appointments.all
      if @appointments
        render json: @appointments, status: :accepted
      else
        render json: 'No Appointments', status: :no_content
      end
    else
      render json: 'unable to authenticate', status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  # set user callback

end
