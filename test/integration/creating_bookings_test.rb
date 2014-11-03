require 'test_helper'

class CreatingBookings < ActionDispatch::IntegrationTest
  def setup
    host! 'example.com'
    @place = create(:place, name: 'Ecosalon')
    @user = create(:user)
    @schedule = create(:schedule, place: @place)
    @services = create_list(:service, 2, place: @place)

    @post_data = { place_id: @place.id,
                   services: @services.map(&:id),
                   user_id: @user.id,
                   date: @schedule.start_time }

    @app = Doorkeeper::Application.create!(
      name: 'Doorkeeper App',
      :redirect_uri => 'urn:ietf:wg:oauth:2.0:oob'
    )

    user = attributes_for(:user)
    post api_v1_signup_path, user

    assert_equal 200, response.status
    data = json(response.body)
    assert_includes data, :access_token

    @bearer = "Bearer #{data[:access_token]}"
  end

  def teardown
    @user.destroy!
    @place.destroy!
    @schedule.destroy!
    @services.map(&:destroy!)
    @post_data = nil
  end

  def test_create_a_booking
    post api_v1_bookings_path, @post_data, authorization: @bearer, client_id: @app.uid

    assert_equal 200, response.status
    refute_empty response.body

    json = json(response.body)

    assert_includes json, :booked_services

    booked_services = json[:booked_services]

    assert_equal @place.id, json[:place_id]
    assert_equal @post_data[:date], json[:date]
    assert_equal @services.first.name, booked_services.first[:service_name]
    assert_equal @services.last.name, booked_services.last[:service_name]
  end

  def test_create_booking_without_services
    post api_v1_bookings_path, @post_data.merge(services: []), authorization: @bearer, client_id: @app.uid

    assert_equal 404, response.status
    refute_empty response.body

    json = json(response.body)
    assert_includes json, :errors
  end
end
