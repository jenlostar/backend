ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/rails/capybara'
require 'minitest/focus'
require 'minitest/pride'
require 'minitest/reporters'

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new(color: true)]

module ActiveSupport
  class TestCase
    ActiveRecord::Migration.check_pending!
    fixtures :all

    include FactoryGirl::Syntax::Methods
    include Warden::Test::Helpers
    Warden.test_mode!

    # ActiveRecord::Base.logger = Logger.new(STDOUT)

    def json(body)
      ::JSON.parse(body, symbolize_names: true)
    end
  end
end
