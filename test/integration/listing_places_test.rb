require 'test_helper'

class ListingPlacesTest < ActionDispatch::IntegrationTest
  def setup
    host! 'example.com'
  end

  def test_returns_list_of_all_places
    places = create_list(:place, 11)
    get api_v1_places_path
    assert_equal 200, response.status
    refute_empty response.body

    data = json(response.body)
    assert_equal 10, data.length

    assert_equal places[0].name, data[0][:name]
    assert_equal places[0].address, data[0][:address]
    assert_equal places[0].description, data[0][:description]
    assert_equal places[0].mobile_phone, data[0][:mobile_phone]
    assert_equal places[0].land_line, data[0][:land_line]

    assert_includes data[0], :services
    assert_includes data[0], :schedules
  end

  def test_return_place_by_id
    place = create(:place, name: 'Ecosalon')
    get api_v1_place_path(place)
    assert_equal 200, response.status

    place_response = json(response.body)
    assert_equal place.name, place_response[:name]
  end
end
