class Question < ActiveRecord::Base
	validates :title, presence: true
	validates :content, presence: true
	
	belongs_to :interview
	belongs_to :question_group
end
