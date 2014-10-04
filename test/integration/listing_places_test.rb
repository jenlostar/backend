require 'test_helper'

class ListingPlacesTest < ActionDispatch::IntegrationTest
  def setup
    host! 'example.com'
  end

  def test_returns_list_of_all_places
    create_list(:place, 11)
    get api_v1_places_path
    assert_equal 200, response.status
    refute_empty response.body

    places_response = json(response.body)
    assert_equal 10, places_response.length
  end

  def test_return_place_by_id
    place = create(:place, name: 'Ecosalon')
    get api_v1_place_path(place)
    assert_equal 200, response.status

    place_response = json(response.body)
    assert_equal place.name, place_response[:name]
  end
end
