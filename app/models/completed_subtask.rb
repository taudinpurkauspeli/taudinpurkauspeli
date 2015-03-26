class CompletedSubtask < ActiveRecord::Base
	belongs_to :user
	belongs_to :subtask
end
