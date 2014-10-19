##
# Esta clase representa una reserva
# @author Jenny Lopez
class Booking < ActiveRecord::Base
  # Tiene varios servicios reservados
  has_many :booked_services

  validates :booked_services, presence: true

  def self.new_with_params(booking_params)
    Booking.new do |booking|

      booking.date = booking_params[:date]
      booking.place_id = booking_params[:place_id]

      Service.where(id: booking_params[:services]).each do |s|
        booking.booked_services.build(service_name: s.name)
      end
    end
  end
end
