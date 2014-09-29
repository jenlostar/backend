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
  end
end
