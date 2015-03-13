class Task < ActiveRecord::Base
	validates :name, presence: true, length: {minimum: 2}
	belongs_to :exercise

  has_many :completed_tasks, dependent: :destroy
  has_many :users, through: :completed_tasks

  has_many :subtasks, dependent: :destroy

  has_many :task_texts, through: :subtasks

  def self.get_highest_level(exercise)
    highest_level = exercise.tasks.maximum("level")
    unless highest_level.nil?
      return highest_level
    else
      return 0
    end
  end

#  def get_highest_level(exercise)
#    e = exercise.tasks
#    e.maximum("level")
#  end
end
