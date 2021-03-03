class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[show edit update destroy]
  
  # GET /appointments/1
  # GET /appointments/1.json
  def show
    @user = User.find_by(id: @appointment.user_id)
    @boat = @user.boat
  end


  # GET /appointments/1/edit
  def edit
  end

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
end
