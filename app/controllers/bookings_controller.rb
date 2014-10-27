class BookingsController < ApplicationController
  def index
    @bookings = Booking.pending_confirm
    @filtered_by = t(:pending_bookings)
  end

  def canceled
    @bookings = Booking.canceled
    @filtered_by = t(:canceled_bookings)
    render 'index'
  end

  def approved
    @bookings = Booking.approved
    @filtered_by = t(:approved_bookings)
    render 'index'
  end

  def approve
    booking = Booking.find(params[:id])
    if booking.update_attribute(:confirmed_at, DateTime.now)
      flash[:success] = t(:booking_approved)
    else
      flash[:error] = t(:booking_not_approved)
    end
    redirect_to bookings_path
  end

  def discard
    booking = Booking.find(params[:id])
    if booking.update_attribute(:canceled_at, DateTime.now)
      flash[:success] = t(:booking_canceled)
    else
      flash[:error] = t(:booking_not_canceled)
    end
    redirect_to bookings_path
  end
end
