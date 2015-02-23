class Task < ActiveRecord::Base
	belongs_to :exercise
  
  has_many :users, through: :completed_tasks
  has_one :subtask
end
