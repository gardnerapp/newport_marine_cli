class HelpsController < ApplicationController
  before_action :authenticate, only: %i[index destroy]

  # todo send dilibro email for these and for appointments


  # GET /helps
  # GET /helps.json
  def index
    @helps = Help.all
  end

  # GET /help
  def new
    @help = Help.new
  end
  

  # POST /helps
  # POST /helps.json
  def create
    @help = Help.new(help_params)

    if @help.save
      redirect_to help_success_path
    else
      redirect_to error_path
    end
  end

  def success
  end

  def privacy

  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_help
    @help = Help.find(params[:id])
  end

  def authenticate
    redirect_to login_path if current_user.nil? || !current_user.is_admin?
  end

end
