class Subtask < ActiveRecord::Base

	belongs_to :task

	has_one :task_text, dependent: :destroy
end
