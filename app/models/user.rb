class User < ActiveRecord::Base
	validates :username, presence: true, uniqueness: true
	validates :realname, presence: true, length: {minimum: 4}
	validates :email, presence: true

  has_secure_password
  
  has_many :checked_hypotheses, dependent: :destroy
  has_many :completed_tasks, dependent: :destroy
  has_many :exercise_hypotheses, through: :checked_hypotheses

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
end