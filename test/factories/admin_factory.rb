FactoryGirl.define do

  password = Faker::Number.number(8)

  factory :admin do
    email { Faker::Internet.email }
    password password
    password_confirmation password
  end
end
