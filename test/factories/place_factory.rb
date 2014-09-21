FactoryGirl.define do
  factory :place do
    name { Faker::Company.name }
    address { Faker::Address.street_address }
    description { Faker::Lorem.sentence(3) }
    mobile_phone { Faker::Number.number(10) }
    land_line { Faker::Number.number(10) }
  end
end
