class AppointmentMailer < ApplicationMailer

  def booking_reminder(appointment)
    @appointment = appointment
    mail to: 'newportmarinedetailing@gmail.com', cc: "gardnerappdevelopment@gmail.com", subject: 'An Appointment was booked !'
  end

  def appointment_reminder(appointment)
    @appointment = appointment
    mail to: @appointment.user.email, subject: 'Upcoming Appointment with Newport Marine Detailing'
  end
end
