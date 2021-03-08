class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[show edit update destroy]
  before_action :authenticate
  
  # TODO ADD JQUEARY for Navrbar burger sess page 404
  def index
    @appointments = Appointment.all
  end

  def unpaid
    if current_user == nil
      redirect_to login_path
    else
      @appointments = Appointment.where(is_paid: false)
    end
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
    @user = User.find_by(id: @appointment.user_id)
    @boat = @user.boat
  end

  # GET /appointments/1/edit
  def edit; end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: 'Appointment was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

    # Only allow a list of trusted parameters through.
  def appointment_params
    params.require(:appointment).permit(:time, :user_id, :services,)
  end

  def authenticate
    redirect_to login_path if current_user.nil? || !current_user.is_admin?
  end

end
