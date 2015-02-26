class Task < ActiveRecord::Base
	validates :name, presence: true, length: {minimum: 2}
	belongs_to :exercise
  
  has_many :users, through: :completed_tasks

  has_many :subtasks, dependent: :destroy

  has_many :task_texts, through: :subtasks
end
