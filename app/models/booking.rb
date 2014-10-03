class Booking < ActiveRecord::Base
  has_many :booked_services
end
