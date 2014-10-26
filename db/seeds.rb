require 'factory_girl'
require 'database_cleaner'

require Rails.root.join('test/factories.rb')

I18n.locale = :en

DatabaseCleaner.strategy = :truncation, { except: %w(admins) }

DatabaseCleaner.clean

Admin.create(
  email: 'foo@bar.com',
  password: '12345678#',
  password_confirmation: '12345678#'
)

20.times do
  place = FactoryGirl.create(:place)
  5.times do
    FactoryGirl.create(:booking, place: place)
  end
end
