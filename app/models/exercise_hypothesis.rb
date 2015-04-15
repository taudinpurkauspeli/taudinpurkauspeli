class ExerciseHypothesis < ActiveRecord::Base

	belongs_to :exercise
	belongs_to :hypothesis
  belongs_to :task

  has_many :checked_hypotheses, dependent: :destroy
  has_many :users, through: :checked_hypotheses

  has_one :hypothesis_group, through: :hypothesis

  amoeba do
    enable
    exclude_association [:checked_hypotheses, :users, :hypothesis_group, :hypothesis, :exercise]
  end

  def get_prerequisite
    return task
  end

  def user_meets_requirements (user)
    return true if task.level < 1
    if(user.completed_tasks.where(task_id: task_id).empty?)
      return false
    end
    return true
  end
end
