# == Schema Information
#
# Table name: bookings
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  place_id     :integer
#  date         :datetime
#  created_at   :datetime
#  updated_at   :datetime
#  confirmed_at :datetime
#  canceled_at  :datetime
#

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

  # método para obtener reservas por confirmar
  scope :pending_confirm, (lambda do
    includes(:place, :user, :booked_services)
    .where(confirmed_at: nil, canceled_at: nil)
    .order(:date)
  end)

  # método para obtener reservas canceladas
  scope :canceled, (lambda do
    where.not(canceled_at: nil).order(:date)
  end)

  # método para obtener reservas aprovadas/confirmadas
  scope :approved, (lambda do
    where.not(confirmed_at: nil).order(:date)
  end)

  # método para obtener las reservas de un día en especifico
  scope :on_day, (lambda do |day|
    where(date: day.beginning_of_day..day.end_of_day).includes(:booked_services)
  end)

  # validaciones
  validates :booked_services, presence: true
  validates :place, presence: true
  validates :user, presence: true
  validates :date, presence: true

  # método que crea una nueva reserva y adiciona los servicios seleccionados
  # por el usuario
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
