require 'test_helper'

class CancelBookingsTest < ActionDispatch::IntegrationTest
  def setup
    host! 'example.com'
    login_as create(:admin), scope: :admin
    @place = create(:place_with_schedules_and_services, name: 'Ecosalon')
    @user = create(:user)
    @booking = create(:booking, place: @place, user: @user)
  end

  def teardown
    @place.destroy
    @user.destroy
    @booking.destroy
  end

  def test_cancel_bookings
    assert_equal 1, Booking.pending_confirm.count

    post discard_booking_path(@booking)
    @booking.reload

    assert_equal 302, response.status
    assert_redirected_to bookings_path
    assert_equal I18n.t(:booking_canceled), flash[:success]
    assert_equal 1, Booking.canceled.count
    refute_nil @booking.canceled_at
  end
end
