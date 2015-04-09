class Option < ActiveRecord::Base
	validates :content, presence: true
	validates :explanation, presence: true

	belongs_to :multichoice

	enum is_correct_answer: %i(allowed required wrong)

	amoeba do
		enable
	end
end
