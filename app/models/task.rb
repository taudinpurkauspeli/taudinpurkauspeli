class Task < ActiveRecord::Base
	belongs_to :exercise
  
  has_many :users, through: :completed_tasks
end
