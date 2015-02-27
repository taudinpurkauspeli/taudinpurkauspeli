class Subtask < ActiveRecord::Base

	validates :task_id, presence: true

	belongs_to :task

	has_one :task_text, dependent: :destroy
end
