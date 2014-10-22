class BookingsController < ApplicationController
  def index
    @bookings = Booking.includes(:place, :booked_services).pending_confirm
  end
end
