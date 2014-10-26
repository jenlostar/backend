##
# Esta clase representa una reserva
# @author Jenny Lopez
class Booking < ActiveRecord::Base
  # Pertenece a
  belongs_to :place

  # Pertenece a
  belongs_to :user

  # Tiene varios servicios reservados
  has_many :booked_services

  scope :pending_confirm, -> { where(confirmed_at: nil).order(:date) }

  validates :booked_services, presence: true
  validates :place, presence: true
  validates :user, presence: true
  validates :date, presence: true

  def self.new_with_params(booking_params)
    services = booking_params.delete(:services)
    booking = Booking.new(booking_params)

    Service.where(id: services).each do |s|
      booking.booked_services.build(
        service_name: s.name,
        service_duration: s.duration
      )
    end

    booking
  end
end
