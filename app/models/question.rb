class Question < ActiveRecord::Base
	validates :title, presence: true
	validates :content, presence: true

	belongs_to :interview
	belongs_to :question_group
  belongs_to :image

	amoeba do
		enable
	end

end
