class Api::SessionsController < ActionController::API

  # Make Sure to Only give over the remember token
  # Exclude the Digest
  # POST api/login

  def create
    @user = User.find_by(phone: params[:session][:phone])
    if @user&.authenticate(params[:session][:password])
      render json: { name: @user.name,
                     email: @user.email,
                     phone: @user.phone,
                     boat: @user.boat,
                     token: @user.remember_token }, status: :accepted
    else
      render json: "no user", status: :unprocessable_entity
    end
  end



end
