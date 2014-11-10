class BookingMailer < ActionMailer::Base
  default from: 'notificationes@mipeluqueria.com'

  add_template_helper(ApplicationHelper)
  add_template_helper(MailerHelper)

  def approve_notification(booking_id)
    @booking = Booking.find_by(id: booking_id)
    @user = @booking.user
    @place = @booking.place
    @services = @booking.booked_services

    mail(to: @user.email, subject: 'Mi Peluquería - Confirmación de reserva')
  end

  def cancel_notification(booking_id)
    @booking = Booking.find_by(id: booking_id)
    @user = @booking.user
    @place = @booking.place
    @services = @booking.booked_services

    mail(to: @user.email, subject: 'Mi Peluquería - Cancelación de reserva')
  end
end
