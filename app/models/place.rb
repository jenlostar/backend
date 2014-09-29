class Place < ActiveRecord::Base
  has_many :schedules, as: :schedulable
  has_many :services

  paginates_per 10
end
