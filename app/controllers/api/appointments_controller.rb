class Api::AppointmentsController < ActionController::API
  # Todo if wash do stuff for weekly & daily
  # POST api/appointments
  # if @appointment.title == 'Daily' || 'Weekly'
  # 1. set last week of operations
  # 2. for each week from present create wash
  # normal save in else
  def create
    @user = User.find_by(id: appointment_params[:user_id])
    if @user&.authenticated?(params[:token])
      @appointment = Appointment.new(appointment_params)
      # if daily, weekly here
      if @appointment.save
        render json: @appointment, status: :accepted
      else
        render json: @appointment.errors.inspect, status: :unprocessable_entity
      end
    else
      render json: 'Unable to Authenticate', status: :unprocessable_entity
    end
  end

  # GET api/appointments/
  # NOT INDEX OF ALL APPOINTMENTS
  # Just the Appointments for User of Type ID
  def index
    @user = User.find_by(index_params[:id])
    if @user&.authenticated?(index_params[:token])
      @appointments = @user.appointments.all
      if @appointments
        render json: @appointments, status: :accepted
      else
        render json: @appointments.errors, status: :unprocessable_entity
      end
    else
      render json: 'unable to authenticate', status: :unprocessable_entity
    end
  end

  private

  # todo private method for setting and authenticating user
  # might just go in helper

  def index_params
    params.require(:user).permit(%i[id token])
  end

  def appointment_params
    params.require(:appointment).permit(%i[time title total user_id services additional_instructions token])
  end

end
