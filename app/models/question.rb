class Question < ActiveRecord::Base
	validates :title, presence: true
	validates :content, presence: true

	belongs_to :interview
	belongs_to :question_group

  has_attached_file :picture, styles: {
    full: '1070>',
    thumb: '100x100#'
  }
    	# Validate the attached image is image/jpg, image/png, etc
  	validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/


	amoeba do
		enable
	end

end
