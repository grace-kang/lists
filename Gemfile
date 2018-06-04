# frozen_string_literal: true
source 'https://rubygems.org'
ruby '2.5.1'
gem 'hanami',       '~> 1.2'
gem 'hanami-model', '~> 1.2'
gem 'pg'
gem 'rake'
gem 'tachiban'
gem 'dry-system'

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
