require 'test_helper'

class CreatingBookings < ActionDispatch::IntegrationTest
  def setup
    host! 'example.com'
    @place = create(:place, name: 'Ecosalon')
    @schedule = create(:schedule, schedulable: @place)
    @services = create_list(:service, 2, place: @place)
    @post_data = {place_id: @place.id, services: @services.map(&:id), date: @schedule.start_time}
  end

  def teardown
    @place.destroy!
    @schedule.destroy!
    @services.map(&:destroy!)
    @post_data = nil
  end

  def test_create_a_booking
    post api_v1_bookings_path, @post_data

    assert_equal 200, response.status
    refute_empty response.body

    json = json(response.body)

    assert_equal @place.id, json[:place_id]
    assert_equal @post_data[:date], json[:date]
    assert_equal @services.first.name, json[:booked_services].first[:service_name]
    assert_equal @services.last.name, json[:booked_services].last[:service_name]
  end

  def test_create_booking_without_services
    post api_v1_bookings_path, @post_data.merge({services: []})

    assert_equal 404, response.status
    refute_empty response.body

    json = json(response.body)
    assert_includes json, :errors
  end
end
