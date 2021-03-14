class Api::BoatsController < ActionController::API

  def create
    @user = User.find_by(id: params[:id])
    if @user&.authenticated?(params[:token])
      @boat = @user.build_boat(boat_params)
      if @boat.save
        render json: @boat, status: :accepted
      else 
        render json: 'Could Not Create Boat', status: :unprocessable_entity
      end
    else
      render json: 'Unable to Authenticate User before Creating boat', status: :unprocessable_entity
    end
  end

  private

  def boat_params
    # How to sanatize multiple parameters
    # params.require(:user_data).permit :user_id, :token
    params.require(:boat).permit(:name, :location, :length)
  end
end
