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
        AppointmentMailer.booking_reminder(@appointment).deliver_now
        render json: @appointment, status: :accepted
      else
        render json: @appointment.errors.inspect, status: :unprocessable_entity
      end
    else
      render json: 'Unable to Authenticate', status: :unprocessable_entity
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(%i[time title total user_id services additional_instructions token daily weekly])
  end

end
