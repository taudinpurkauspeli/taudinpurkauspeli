class Conclusion < ActiveRecord::Base
	belongs_to :subtask

	belongs_to :exercise_hypothesis


	def user_answered_correctly?(user, final_conclusion)
		puts "USER ANSWARED: " + final_conclusion + "OIKEA VASTAUS: " + exercise_hypothesis.class.to_s
		if final_conclusion == exercise_hypothesis.id
			puts "OKEIN: " + final_conclusion.to_s
			user.complete_subtask(subtask)
			return true
		else
			puts "VÄÄRIN" + final_conclusion.to_s
			return false
		end
	end
end
