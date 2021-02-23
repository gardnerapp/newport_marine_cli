class Api::SessionsController < ActionController::API

  # Make Sure to Only give over the remember token
  # Exclude the Digest
  # POST api/login
  def create
    @user = User.find_by(phone: session_params[:phone])
    if @user&.authenticate(session_params[:password])
      render json: @user, status: :accepted
    else
      render json: "no user", status: :unprocessable_entity
    end
  end

  private
  def session_params
    params.permit(:phone, :password)
  end

  # TODO Sanatize session paramaters for only phone, password
  # delete will be handled within the application
end
