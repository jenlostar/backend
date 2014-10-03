require 'test_helper'

class ListingPlacesTest < ActionDispatch::IntegrationTest
  setup {host! 'example.com'}

  test 'returns list of all places' do
    create_list(:place, 11)
    get api_v1_places_path
    assert_equal 200, response.status
    refute_empty response.body

    places_response = json(response.body)
    assert_equal 10, places_response.length
  end

  test 'return place by id' do
    place = create(:place, name: 'Ecosalon')
    get api_v1_place_path(place)
    assert_equal 200, response.status

    place_response = json(response.body)
    assert_equal place.name, place_response[:name]
  end
end
