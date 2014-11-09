require 'test_helper'

class CreatingRatings < ActionDispatch::IntegrationTest
  def setup
    host! 'example.com'
    @place = create(:place, name: 'Ecosalon')
    @user = create(:user)

    @post_data = { place_id: @place.id,
                   user_id: @user.id,
                   value:  (0..5).to_a.sample}

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
    @post_data = nil
  end

  def test_create_a_booking
    post api_v1_ratings_path, @post_data, authorization: @bearer, client_id: @app.uid

    assert_equal 200, response.status
    refute_empty response.body

    json = json(response.body)

    assert_equal @place.id,          json[:place_id]
    assert_equal @user.id,           json[:user_id]
    assert_equal @post_data[:value], json[:value]
    assert_equal @post_data[:value], json[:place_rating_avg]
  end
end
