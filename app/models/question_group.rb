class QuestionGroup < ActiveRecord::Base
	belongs_to :interview
	has_many :questions, dependent: :destroy
end
