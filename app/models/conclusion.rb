class Conclusion < ActiveRecord::Base
	 validates :title, presence: true, length: {minimum: 2}

	belongs_to :subtask
	belongs_to :exercise_hypothesis

	def user_answered_correctly?(user, final_conclusion)
		if final_conclusion.to_i == exercise_hypothesis.id
			user.complete_subtask(subtask)
			return true
		else
			return false
		end
	end

  def to_s
    'Päätöstoimenpide'
  end
end
