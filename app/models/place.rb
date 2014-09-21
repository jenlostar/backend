class Place < ActiveRecord::Base
  has_many :schedules, as: :schedulable
end
