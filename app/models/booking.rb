class Booking < ActiveRecord::Base
  has_many :booked_services

  validates :booked_services, presence: true
end
