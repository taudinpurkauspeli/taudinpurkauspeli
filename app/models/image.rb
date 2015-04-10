class Image < ActiveRecord::Base

  has_attached_file :image, styles: {
    original: '1070>',
    thumb: '100x100#'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
