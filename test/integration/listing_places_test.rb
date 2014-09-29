require 'test_helper'

class ListingPlacesTest < ActionDispatch::IntegrationTest
  setup {host! 'example.com'}

  test 'returns list of all places' do
    get '/api/v1/places'
    assert_equal 200, response.status
    refute_empty response.body
  end

  test 'return place by id' do
    place = create(:place, name: 'Ecosalon')
    get "/api/v1/places/#{place.id}"
    assert_equal 200, response.status

    place_response = json(response.body)
    assert_equal place.name, place_response[:name]
  end
end
