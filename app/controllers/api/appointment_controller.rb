class Api::AppointmentController < ActionController::API

  # TODO Authenticate with Token before actions
  # POST api/appointments
  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      render json: @appointment, status: :accepted
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  # GET api/appointments/
  # NOT INDEX OF ALL APPOINTMENTS
  # Just the Appointments for User of Type ID
  # Only get the ones from the Future
  def index
    @user = User.find_by(appointment_index_params)
    @appointments = @user.appointments.all
    if @appointments
      render json: @appointments, status: :accepted
    else
      render json: @appointments.errors, status: :unprocessable_entity
    end
  end

  private
  def appointment_params
    params.require(:appointment)
  end

  def appointment_index_params
    params.require(:id)
  end

end
