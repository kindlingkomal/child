source 'https://rubygems.org'

ruby "2.2.0"

gem 'activeadmin', github: 'activeadmin'
gem 'schema_plus'
gem 'active_model_serializers', :github => 'rails-api/active_model_serializers'
gem 'rails', '4.2.4'
gem 'puma'
gem 'pg'
gem 'devise'
gem 'gcm'
gem 'fog', require: 'fog/aws'
gem 'mini_magick'
gem 'carrierwave'
gem 'kaminari'
gem 'arel-helpers'
gem 'geocoder'
gem 'ratyrate'

group :staging, :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'figaro'
  gem 'spring'
  gem 'pry-rails'
  gem 'web-console', '~> 2.0'
  gem 'rspec-rails', require: false
end

group :test do
  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false
  gem 'mutant'
  gem 'mutant-rspec'
end
