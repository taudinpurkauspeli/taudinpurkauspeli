class Option < ActiveRecord::Base
	validates :content, presence: true
	validates :explanation, presence: true

	belongs_to :multichoice

	amoeba do
		enable
	end

  has_attached_file :picture, styles: {
    original: '1070>',
    thumb: '100x100#'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

end
