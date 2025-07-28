class FeaturedImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process :resize_to_limit

  def resize_to_limit
    cloudinary_transformation transformation [
      { width: 1024, height: 768, crop: limit }
    ]
  end
end
