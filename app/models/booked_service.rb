##
# Esta clase representa los servicios de una reserva
# @author Jenny Lopez
class BookedService < ActiveRecord::Base
  # Pertenece a Reserva
  belongs_to :booking
end
