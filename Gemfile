source 'https://rubygems.org'

ruby '2.1.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'

# Use postgresql as the database for Active Record
gem 'pg'

# devise
gem 'devise'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# UI
gem 'haml-rails'
gem 'bootstrap-sass', '~> 3.2.0'
gem 'font-awesome-rails'
gem 'simple_form'
gem 'chosen-rails'

# Time in words
gem 'dotiw', github: 'radar/dotiw', branch: 'upgrade'

# Paginator
gem 'kaminari-bootstrap'

# Web server
gem 'unicorn'

group :development do
  gem 'meta_request'
  gem 'quiet_assets'
  gem 'bullet'
  gem 'railroady'
end

group :test, :development do
  gem 'pry'
  gem 'minitest-rails'
  gem 'minitest-rails-capybara'
  gem 'minitest-focus'
  gem 'minitest-reporters'
end

gem 'factory_girl'
gem 'faker'

group :test do
  gem 'cucumber-rails', '~> 1.4.1', require: false
  gem 'database_cleaner', '~> 1.3.0'
  gem 'poltergeist'
  gem 'factory_girl_rails', '~> 4.0'
end

group :production do
  gem 'rails_12factor'
end
