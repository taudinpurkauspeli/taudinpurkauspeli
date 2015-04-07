class Multichoice < ActiveRecord::Base
	validates :question, presence: true

	belongs_to :subtask
	has_many :options, dependent: :destroy

	amoeba do
		enable
		include_association :options
	end

	def user_answered_correctly?(user, checked_options)
		right_answers = options.where(is_correct_answer:true).map(&:id).map!(&:to_s)
		if (right_answers - checked_options).empty? && (checked_options - right_answers).empty?
			user.complete_subtask(subtask)
			return true
		else
			return false
		end
	end
end
