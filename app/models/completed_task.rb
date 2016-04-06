class CompletedTask < ActiveRecord::Base
  validates :task_id, presence: true
  validates :user_id, presence: true
  validate :cannot_complete_same_task_many_times

  belongs_to :user
  belongs_to :task

  has_one :exercise, through: :task

  def cannot_complete_same_task_many_times

    if user_id.present? && task_id.present?
      how_many_completed_tasks = CompletedTask.where(user_id: user_id, task_id: task_id)
      if how_many_completed_tasks.count > 0
        errors.add(:base, 'User has already completed this task')
      end
    end
  end

  def has_exercise?(exercisee)
  	return exercise.id == exercisee.id
  end
end
