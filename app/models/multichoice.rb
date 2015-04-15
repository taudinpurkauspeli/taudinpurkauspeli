class Multichoice < ActiveRecord::Base
	validates :question, presence: true

	belongs_to :subtask
	has_many :options, dependent: :destroy

	amoeba do
		enable
		include_association :options
	end

	def user_answered_correctly?(user, checked_options)
		if contains_all_right_answers(checked_options) && !contains_wrong_answers(checked_options)
			user.complete_subtask(subtask)
			return true
		else
			return false
		end
	end

	private

	def contains_all_right_answers(answered)
		right_answers = options.required.map(&:id).map!(&:to_s)

		return (right_answers - answered).empty?
	end

	def contains_wrong_answers(answered)
		wrong_answers = options.wrong.map(&:id).map!(&:to_s)
		result = wrong_answers - answered

		return !(wrong_answers.count == result.count)
	end


end
