# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  def default_url
    #ActionController::Base.helpers.asset_url("fallback/" + [version_name, "default.png"].compact.join('_'))
    ActionController::Base.asset_host + "/assets/" + ("fallback/" + [version_name, "default.png"].compact.join('_'))
  end

  version :thumb do
    process :resize_to_limit => [66, 66]
  end
  
  version :large do
    process :resize_to_limit => [235, 235]
  end
  
end