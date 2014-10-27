require 'test_helper'

class ApproveBookingsTest < ActionDispatch::IntegrationTest
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

  def test_approve_booking
    assert_equal 1, Booking.pending_confirm.count

    post approve_booking_path(@booking)
    @booking.reload

    assert_equal 302, response.status
    assert_redirected_to bookings_path
    assert_equal I18n.t(:booking_approved), flash[:success]
    assert_equal 0, Booking.pending_confirm.count
    refute_nil @booking.confirmed_at
  end
end
