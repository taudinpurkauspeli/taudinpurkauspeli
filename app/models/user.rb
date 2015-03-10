class User < ActiveRecord::Base
	validates :username, presence: true, uniqueness: true
	validates :realname, presence: true, length: {minimum: 4}
	validates :email, presence: true

  has_secure_password
  
  has_many :checked_hypotheses, dependent: :destroy
  has_many :completed_tasks, dependent: :destroy
  has_many :exercise_hypotheses, through: :checked_hypotheses

  def get_level(exercise)
    # TODO fix to only check tasks of parameter exercise
    latest_completed_task = completed_tasks.last
    unless latest_completed_task.nil?
      latest_completed_task.task.level
    else
      return 0
  end
end
