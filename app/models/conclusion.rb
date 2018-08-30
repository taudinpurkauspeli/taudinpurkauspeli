class Conclusion < ActiveRecord::Base
	validates :title, presence: true, length: {minimum: 2}

	belongs_to :subtask
	belongs_to :exercise_hypothesis
	has_one :task, through: :subtask

	amoeba do
		enable
	end

	def user_answered_correctly?(user, final_conclusion)
		if exercise_hypothesis
			if final_conclusion.to_i == exercise_hypothesis.id
				user.complete_subtask(subtask)
				return true
			else
				return false
			end
		end
		return false
	end

	def to_s
		'Diagnoositoimenpide'
	end
end
