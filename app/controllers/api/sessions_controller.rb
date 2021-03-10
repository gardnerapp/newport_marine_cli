class Api::SessionsController < ActionController::API

  # POST api/login
  def create
    @user = User.find_by(phone: session_params[:phone])
    if @user&.authenticate(session_params[:password])
      @user.remember
      render json: {
        id: @user.id,
        name: @user.name,
        email: @user.email,
        phone: @user.phone,
        boat: @user.boat,
        token: @user.remember_token }, status: :accepted
    else
      render json: 'no user', status: :unprocessable_entity
    end
  end

  private

  def session_params
    params.require(:user).permit :phone, :password
  end

end
