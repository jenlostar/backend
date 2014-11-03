# == Schema Information
#
# Table name: booked_services
#
#  id               :integer          not null, primary key
#  booking_id       :integer
#  service_name     :string(50)
#  service_duration :time
#  created_at       :datetime
#  updated_at       :datetime
#

##
# Esta clase representa los servicios de una reserva
# @author Jenny Lopez
class BookedService < ActiveRecord::Base
  # Pertenece a Reserva
  belongs_to :booking

  validates :service_name, presence: true
  validates :service_duration, presence: true
end
