CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     '123',
    aws_secret_access_key: 'abc'
  }
  config.fog_directory  = ENV['AWS_BUCKET']
  config.fog_public     = true
  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
end
