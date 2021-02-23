class Api::UsersController < ActionController::API
  before_action :set_user, only: %i[show update]
  # GET /api/users/:id

  # POST /api/users
  # Make Sure to only return the remember_token and exclude the remember digestx
  def create
    @user = User.new(user_params)
    if @user.save
      # create token here
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  #PATCH/PUT /api/users/:id.json
  # TODO Re-Authenticate before updating
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.json {render :show, status: :ok, location: @user}
      else
        format.json {render json: @hog.errors, status: :unprocessable_entity}
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone,
                                 :password, :password_confirmation)
  end

end
