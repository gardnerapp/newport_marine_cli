class AppointmentMailer < ApplicationMailer

  def booking_reminder(appointment)
    @appointment = appointment
    mail to: 'c0reygardner63@gmail.com', subject: 'OOPS!'
  end

  def appointment_reminder(appointment)
    @appointment = appointment
    mail to: @appointment.user.email, subject: 'Upcoming Appointment with Newport Marine Detailing'
  end
end
