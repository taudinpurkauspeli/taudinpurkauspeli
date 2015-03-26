class TaskText < ActiveRecord::Base
	validates :content, presence: true

	belongs_to :subtask

  def user_answered_correctly?(user)
    user.complete_subtask(subtask)
    return true
  end
end
