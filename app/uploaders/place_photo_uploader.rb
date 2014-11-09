# encoding: utf-8

class PlacePhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :postgresql_lo
  process convert:  'jpg'
  process resize_to_fill: [420, 340]

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
