# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    if Rails.env.production?
      "ragpickers/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    elsif Rails.env.development?
      "dev/ragpickers/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    else
      "test/ragpickers/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  def scale(width, height)
    # convert 'jpg'
    resize_to_fill(width, height)
  end

  version :medium do
    process :scale => [1080, 386]
  end

  version :small do
    process :scale => [720, 258]
  end

  version :thumbnail do
    process :scale => [90, 90]
  end

end
