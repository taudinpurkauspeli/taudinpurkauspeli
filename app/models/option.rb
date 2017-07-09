class Option < ActiveRecord::Base
	validates :explanation, presence: true

	belongs_to :multichoice
	belongs_to :title

	enum is_correct_answer: %i(allowed required wrong)

	amoeba do
		enable
	end
end
