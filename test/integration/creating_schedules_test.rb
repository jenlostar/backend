require 'test_helper'

class CreatingSchedules < ActionDispatch::IntegrationTest
  def setup
    host! 'example.com'
    login_as create(:admin), scope: :admin

    @place = create(:place, name: 'Ecosalon')

    @post_data = {
      schedule: {
        start_time: Time.new(2014, 1, 1, 8, 0, 0),
        end_time: Time.new(2014, 1, 1, 12, 0, 0),
        day_of_week: Schedule::DAYS.values
      }
    }
  end

  def teardown
    @place.destroy!
    @post_data = nil
  end

  def test_create_an_schedule
    post place_schedules_path(@place), @post_data

    assert_equal 302, response.status
    refute_empty response.body

    assert_redirected_to edit_place_path(@place)
    assert_equal I18n.t(:schedule_created), flash[:success]
  end

  def test_create_an_schedule_without_days_selected
    @post_data[:schedule].delete(:day_of_week)
    post place_schedules_path(@place), @post_data

    assert_equal 200, response.status
    refute_empty response.body
  end
end
