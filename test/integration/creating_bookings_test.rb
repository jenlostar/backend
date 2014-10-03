require 'test_helper'

class CreatingBookings < ActionDispatch::IntegrationTest
  setup {host! 'example.com'}

  test 'create a booking' do
    place = create(:place, name: 'Ecosalon')
    schedule = create(:schedule, schedulable: place)
    services = create_list(:service, 2, place: place)

    post_data = {
      place_id: place.id,
      services: services.map(&:id),
      date: schedule.start_time
    }

    post api_v1_bookings_path, post_data
    assert_equal 200, response.status
    refute_empty response.body

    booking_response = json(response.body)

    assert_equal place.id, booking_response[:place_id]
    assert_equal post_data[:date], booking_response[:date]

    assert_equal services.first.name, booking_response[:booked_services].first[:service_name]
    assert_equal services.last.name, booking_response[:booked_services].last[:service_name]
  end
end
