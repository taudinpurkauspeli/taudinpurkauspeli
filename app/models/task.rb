class Task < ActiveRecord::Base
	validates :name, presence: true, length: {minimum: 2}
	belongs_to :exercise

  has_many :completed_tasks, dependent: :destroy
  has_many :users, through: :completed_tasks

  has_many :subtasks, dependent: :destroy

  has_many :task_texts, through: :subtasks

  def self.find_highest_level
    Task.maximum("level")
  end

#  def find_highest_level(exercise)
#    e = exercise.tasks
#    e.maximum("level")
#  end
end
