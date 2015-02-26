class Subtask < ActiveRecord::Base

 # validates :task_id, presence: true
 # validates :task_text_id, presence: true

	belongs_to :task
	has_one :task_text
end
