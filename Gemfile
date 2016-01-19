source 'https://rubygems.org'

ruby "2.3.0"

gem 'cancancan'
gem 'simple_form'
gem 'activeadmin', '1.0.0.pre2' #, github: 'activeadmin'
gem 'delayed_job_active_record'
gem 'active_model_serializers', '0.10.0.rc3' #:github => 'rails-api/active_model_serializers'
gem 'rails', '4.2.4'
gem 'jquery-rails'
gem 'strip_attributes'
gem 'font-awesome-rails'
gem 'puma'
gem 'pg'
gem 'devise', '3.5.2'
gem 'gcm'
gem 'figaro'
gem 'fog', require: 'fog/aws'
gem 'mini_magick'
gem 'carrierwave'
gem 'kaminari'
gem 'arel-helpers'
gem 'geocoder'
gem 'paloma'
gem 'ratyrate', '1.2.2.alpha'
gem 'haml-rails'
gem "rest-client"
gem 'twilio-ruby'
gem 'phonelib'

group :staging, :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'letter_opener'
  gem 'quiet_assets'
  gem 'spring'
  gem 'pry-rails'
  gem 'web-console', '~> 2.0'
  gem 'rspec-rails', require: false
end

group :development do
  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
  gem 'capistrano3-delayed-job', require: false
end

group :test do
  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false
  gem 'mutant'
  gem 'mutant-rspec'
end
