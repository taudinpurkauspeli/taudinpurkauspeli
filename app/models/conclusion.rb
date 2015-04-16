class Conclusion < ActiveRecord::Base
	belongs_to :subtask

	belongs_to :exercise_hypothesis


	def user_answered_correctly?(user, final_conclusion)
		if true
			user.complete_subtask(subtask)
			return true
		else
			return false
		end
	end
end
