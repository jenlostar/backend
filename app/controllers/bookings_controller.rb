class BookingsController < ApplicationController
  def index
    @bookings = Booking.includes(:place, :user, :booked_services).pending_confirm
  end
end
