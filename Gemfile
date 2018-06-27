# frozen_string_literal: true
source 'https://rubygems.org'

ruby '2.5.1'
gem 'dry-system'
gem 'hanami',       '~> 1.2'
gem 'hanami-model', '~> 1.2'
gem 'hanami-webpack', github: 'samuelsimoes/hanami-webpack'
gem 'hanami-serializer', github: 'davydovanton/hanami-serializer'
# gem 'jsonapi-hanami'
gem 'pg'
gem 'pry'
gem 'rake'
gem 'tachiban'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'hanami-webconsole'
  gem 'shotgun', platforms: :ruby
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
end

group :test do
  gem 'capybara'
  gem 'minitest'
end

group :production do
  # gem 'puma'
end
