# == Schema Information
#
# Table name: ratings
#
#  id         :integer          not null, primary key
#  place_id   :integer
#  user_id    :integer
#  value      :integer
#  created_at :datetime
#  updated_at :datetime
#

class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :place

  scope :for_place, ->(place_id) { where(place_id: place_id).group(:place_id).average(:value) }

  validates :user, presence: true
  validates :place, presence: true

  validates :value, presence: true, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 5
  }
end
