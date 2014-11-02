require 'test_helper'

class ListingPlacesTest < ActionDispatch::IntegrationTest
  def setup
    host! 'example.com'
  end

  def test_returns_list_of_all_places
    place = create(:place_with_schedules_and_services)

    get api_v1_places_path
    assert_equal 200, response.status

    refute_empty response.body

    data = json(response.body).first

    assert_equal place.name,         data[:name]
    assert_equal place.address,      data[:address]
    assert_equal place.description,  data[:description]
    assert_equal place.mobile_phone, data[:mobile_phone]
    assert_equal place.land_line,    data[:land_line]

    assert_includes data, :services
    assert_includes data, :schedules
  end

  def test_return_place_by_id
    place = create(:place, name: 'Ecosalon')
    get api_v1_place_path(place)
    assert_equal 200, response.status

    place_response = json(response.body)
    assert_equal place.name, place_response[:name]
  end
end
