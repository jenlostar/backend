class Place < ActiveRecord::Base
  has_many :schedules, as: :schedulable
  has_many :services
end
