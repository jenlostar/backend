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

    data = json(response.body)

    assert_equal place.name,         data.first[:name]
    assert_equal place.address,      data.first[:address]
    assert_equal place.description,  data.first[:description]
    assert_equal place.mobile_phone, data.first[:mobile_phone]
    assert_equal place.land_line,    data.first[:land_line]

    assert_includes data.first, :services
    assert_includes data.first, :schedules
  end

  def test_return_place_by_id
    place = create(:place, name: 'Ecosalon')
    get api_v1_place_path(place)
    assert_equal 200, response.status

    place_response = json(response.body)
    assert_equal place.name, place_response[:name]
  end
end
