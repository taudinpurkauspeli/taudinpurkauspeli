class TaskText < ActiveRecord::Base

	validates :content, presence: true

	belongs_to :subtask

end
