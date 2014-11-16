require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'
# require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Backend
  class Application < Rails::Application
    config.i18n.default_locale = :es
    config.time_zone = 'Bogota'

    config.generators do |g|
      g.test_framework :minitest, spec: false, fixture: false
      g.helper false
      g.assets false
      g.view_specs false
    end
  end
end
