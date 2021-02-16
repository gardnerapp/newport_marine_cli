class Api::SessionsController < ActionController::API

  # POST api/login
  def create
    @user = User.find_by(phone: params[:phone])
    if @user&.authenticate(params[:password])
      render json: @user, status: :accepted
    else
      render json: "no user", status: :unprocessable_entity
    end
  end


  # TODO Sanatize session paramaters for only phone, password
  # delete will be handled within the application
end
