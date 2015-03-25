class User < ActiveRecord::Base
	validates :username, presence: true, uniqueness: true
	validates :realname, presence: true, length: { minimum: 4 }
	validates :email, presence: true

  has_secure_password
  
  has_many :checked_hypotheses, dependent: :destroy
  has_many :completed_tasks, dependent: :destroy
  has_many :exercise_hypotheses, through: :checked_hypotheses
  has_many :completed_subtasks, dependent: :destroy
  has_many :subtasks, through: :completed_subtasks

  def can_complete_subtask?(task, subtask)
    last_subtask_level = subtasks.where(task:task).maximum("level")

    # user has completed some subtasks
    unless last_subtask_level.nil?
      # get first subtasks whose level >= user's last completed subtask
      next_sub = (task.subtasks.where(level:last_subtask_level + 1...999).limit 1)[0]
      if next_sub == subtask
        return true
      else
        return false
      end
    # user has not completed any subtasks
    else
      # user is trying to do the first subtask of a task
      if subtask.level == task.subtasks.minimum("level")
        return true
      end
    end
    return false
  end

  def get_number_of_tasks_by_level(exercise, level)
    number_of_tasks = 0
    completed_tasks.each do |c|
      unless c.task.nil? 
        if(c.task.level == level && c.task.exercise_id == exercise.id)
          number_of_tasks += 1
        end
      end
    end
    return number_of_tasks
  end

  def has_completed_task(id)
    return completed_tasks.where(id:id).nil?
  end
end