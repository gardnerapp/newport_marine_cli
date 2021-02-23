class Api::BoatsController < ActionController::API

  # need some way to validate to make sure that the boat is not being created by someone without authentication

  def create
    @user = User.find(params[:id])
    if @user
      @boat = @user.boats.build(boat_params)
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
    params.require(:boat).permit(:name, :location, :length)
  end
end
