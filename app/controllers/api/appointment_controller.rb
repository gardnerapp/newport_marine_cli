class Api::AppointmentController < ActionController::API

  # POST api/appointments
  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      render json: @appointment, status: :ok
    else
      render json: @appointment.errors, status: :ok
    end
  end

  # GET api/appointments/
  # NOT INDEX OF ALL APPOINTMENTS
  # Just the Appointments for User of Type ID
  def index
    @user = User.find_by(params[:user_id])
    @appointments = @user.appointments.all
    if @appointments
      render json: @appointments, status: :ok
    else
      render json: @appointments.errors, status: :unprocessable_entity
    end
  end

  private
  def appointment_params
    params.require(:appointment).permit(:time, :user_id)
  end

end
