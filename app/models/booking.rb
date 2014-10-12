##
# Esta clase representa una reserva
# @author Jenny Lopez
class Booking < ActiveRecord::Base
  # Tiene varios servicios reservados
  has_many :booked_services

  validates :booked_services, presence: true
end
