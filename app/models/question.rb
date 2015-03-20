class Question < ActiveRecord::Base
	validates :title, presence: true
	validates :content, presence: true
	validates :required, presence: true

	belongs_to :question_group
end
