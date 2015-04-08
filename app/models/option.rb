class Option < ActiveRecord::Base
	validates :content, presence: true
	validates :explanation, presence: true

	belongs_to :multichoice

	amoeba do
		enable
	end
end
