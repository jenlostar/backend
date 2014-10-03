FactoryGirl.define do

  password = Faker::Number.number(8)

  factory :admin do
    email { Faker::Internet.email }
    password password
    password_confirmation password
  end

  factory :place do
    name { Faker::Company.name }
    address { Faker::Address.street_address }
    description { Faker::Lorem.sentence(3) }
    mobile_phone { Faker::Number.number(10) }
    land_line { Faker::Number.number(10) }

    # after(:build) do |place|
    #   place.schedules = build_list(:schedule, 1, schedulable: place)
    #   place.services = build_list(:service, 1, place: place)
    # end
  end

  factory :schedule do
    day_of_week 1
    start_time Time.new(2014, 1, 1, 8,0,0)
    end_time Time.new(2014, 1, 1, 12,0,0)
    association :schedulable, :factory => :place
  end

  factory :service do
    name { Faker::Lorem.paragraph[1..50].strip }
    minimum_amount { Faker::Number.number(3) }
    maximum_amount { Faker::Number.number(4) }
    duration { Time.new(2014, 1, 1, 0,15,0) }
    association :place, :factory => :place
  end
end
