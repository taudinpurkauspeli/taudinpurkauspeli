class Option < ActiveRecord::Base
	validates :content, presence: true
	validates :explanation, presence: true

	belongs_to :multichoice
  belongs_to :image

	amoeba do
		enable
	end
end
