class CompletedSubtask < ActiveRecord::Base
	belongs_to :user
	belongs_to :subtask

	validate :cannot_complete_same_subtask_many_times

	def cannot_complete_same_subtask_many_times

		if user_id.present? && subtask_id.present?
			how_many_completed_subtasks = CompletedSubtask.where(user_id: user_id, subtask_id: subtask_id)
			if how_many_completed_subtasks.count > 0
				errors.add(:base, 'User has already completed this subtask')
			end
		end
	end

end
