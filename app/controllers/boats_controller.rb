class BoatsController < ApplicationController<ActionController::API

  # POST /boats
  def create
    @boat = Boat.new(boat_params)
    if @boat.save
      #handle save
    else
      # handle invalid save
    end
  end

  private

  def boat_params
    params.require(:boat).permit(:name, :location, :length, :user_id)
  end

end
